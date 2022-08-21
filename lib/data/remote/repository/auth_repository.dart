import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:square_tickets/data/remote/models/user_model.dart';

import '../models/api_response.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<ApiResponse> signInWithGoogle(bool register) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
        'email',
        'profile',
      ]).signIn();

      // Obtain the auth details from the request
      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        // Once signed in, return the UserCredential
        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential).then((value) {
          log(value.user.toString());
          return value;
        });

          DocumentReference userRef = await db.collection('users').doc(userCredential.user?.uid);
          userRef.get().then((value) async {
            if(value.exists){
              return ApiResponse(data: userCredential, error: 'User already exists');

            }else{
              await userRef.set(UserModel(
                  userId: userCredential.user!.uid,
                  name: userCredential.user!.displayName.toString(),
                  email: userCredential.user!.email.toString(),
                  balance: 0,
                  hosted: 0)
                  .toJson());
              log(userCredential.user.toString());


              return ApiResponse(data: userCredential, error: null);
            }
          });
        return ApiResponse(data: userCredential, error: null);


      } else {
        log('not signed in');
        return ApiResponse(data: null, error: 'Unsuccessful');
      }
    } on FirebaseAuthException catch (e) {
      log('FIREBASE ERROR${e.message.toString()}');
      return ApiResponse(data: null, error: e.code);
    }
  }


  Stream<User?> authState() {
    return _firebaseAuth.authStateChanges();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getUser(String uid) {
    log(_firebaseAuth.currentUser!.uid.toString());

    return db.collection('users').doc(_firebaseAuth.currentUser!.uid).snapshots();






  }
  Future<ApiResponse> register(String email, password, name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      DocumentReference userRef = await db.collection('users').doc(userCredential.user?.uid);
      await userRef.set(UserModel(
              userId: userCredential.user!.uid,
              name: name,
              email: email,
              balance: 0,
              hosted: 0)
          .toJson());
      if (userCredential != null) {
        return ApiResponse(data: 'registered', error: null);
      } else {
        return ApiResponse(data: 'registered', error: 'Failed');
      }
    } on FirebaseAuthException catch (e) {
      return ApiResponse(data: null, error: e.code);
    }
  }

  Future<ApiResponse> signInWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      log('signed in');

      if (userCredential != null) {
        return ApiResponse(data: 'signed in', error: null);
      } else {
        return ApiResponse(data: null, error: 'Error');
      }
      return ApiResponse(data: 'signed in', error: null);
    } on FirebaseAuthException catch (e) {
      log(e.toString());

      return ApiResponse(data: e.code, error: e.code);
    } catch (e) {
      log(e.toString());

      return ApiResponse(data: e, error: e.toString());
    }
  }

  Future<ApiResponse> logoutUser() async {
    try {
      GoogleSignIn().signOut();
      _firebaseAuth.signOut();
      log('signed out');
      return ApiResponse(data: 'signed out', error: null);
    } on Exception catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }
  }
}
