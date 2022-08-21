import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:square_tickets/data/remote/models/user_model.dart';
import 'package:square_tickets/presenter/bloc/events_bloc/events_bloc.dart';

import '../../../data/remote/models/api_response.dart';
import '../../../data/remote/repository/auth_repository.dart';
import '../../../di/injector.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    _authRepository.authState().listen((event) {
      if (event != null) {
        log('USER ${'LISTENING : EVENT ID IS NOT  NULL'}');
        injector.get<AuthBloc>().add((AuthStateChangedEvent(event.uid)));
        uid = event.uid;
         _authRepository.getUser(event.uid)?.listen((event) {
                log(event.data()!.length.toString());

                if (event.data() != null) {
              userModel = UserModel.fromJson(event.data()!);
              log(userModel.toString());
            } else {
              log('GET USER EVENT IS NULL');
            }
          });
      } else if (event == null) {
        log('USER ${'LISTENING :EVENT ID IS  NULL'}');

        injector.get<AuthBloc>().add((AuthStateChangedEvent(null)));
      }
    });

    on<AuthEvent>((event, emit) {});
    on<GoogleSigninEvent>(_mapGoogleSigninEventToState);
    on<AuthStateChangedEvent>(_mapAuthStateChangedEvent);
    on<LogoutEvent>(_mapLogoutEventToState);
    on<RegisterUserEvent>(_mapRegisterEventToState);
    on<LoginEvent>(_mapLoginEventToState);
  }

  final AuthRepository _authRepository = AuthRepository();

  UserModel? userModel;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSubscription;
  String uid = '';

  Future<FutureOr<void>> _mapGoogleSigninEventToState(
      GoogleSigninEvent event, Emitter<AuthState> emit) async {
    emit(GoogleSigninLoadingState());

    try {
      ApiResponse response = await _authRepository.signInWithGoogle(event.register);
      if (response.error == null) {
        emit(GoogleSigninSuccesState());
      } else {
        emit(GoogleSigninFailureState(error: response.error));

        log(response.error);
      }
    } on Exception catch (e) {
      log(e.toString());

      emit(GoogleSigninFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapAuthStateChangedEvent(
      AuthStateChangedEvent event, Emitter<AuthState> emit) {
    emit(AuthStateChangedState(event.uid));
  }

  FutureOr<void> _mapLogoutEventToState(
      LogoutEvent event, Emitter<AuthState> emit) {
    emit(LogoutLoadingState());
    try {
      _authRepository.logoutUser();
      emit(LogoutSuccesState());
    } on FirebaseException catch (e) {
      emit(LogoutFailureState(error: e.message.toString()));
    }
  }

  FutureOr<void> _mapRegisterEventToState(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    try {
      ApiResponse response = await _authRepository.register(
          event.email, event.password, event.name);
      if (response.error == null) {
        emit(RegisterSuccesState());
      } else {
        emit(RegisterFailureState(error: response.error));
      }
    } on Exception catch (e) {
      emit(RegisterFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapLoginEventToState(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    try {
      ApiResponse response = await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (response.error == null) {
        emit(LoginSuccesState());
      } else {
        emit(LoginFailureState(error: response.error));
      }
    } on Exception catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }
}
