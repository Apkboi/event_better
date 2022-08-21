import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:square_tickets/data/remote/events/models/event_model.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/data/remote/models/api_response.dart';

class DataRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<ApiResponse> addEvent(
      {required EventModel event, required List<String> photos}) async {
    try {
      DocumentReference eventRef = db.collection('events').doc();
      log('PHOTOS LENGTH${photos.length.toString()}');

      ApiResponse sameImageRespone =
          await saveEventImage(eventRef.path, photos);

      if (sameImageRespone.error == false) {
        eventRef.set(event
            .copyWith(id: eventRef.id, posterUrl: sameImageRespone.data)
            .toJson());
        return ApiResponse(data: event, error: null);
      } else {
        eventRef.delete();
        return ApiResponse(
            data: sameImageRespone.error, error: 'An error occurred retry');
      }
      // DocumentReference eventRef = db.collection('events').doc();
    } on Exception catch (e) {
      return ApiResponse(data: e, error: e.toString());
    }
  }

  // Future<ApiResponse> updateEvent({required EventModel event,required List<String> photos}) async {
  //   try {
  //
  //     DocumentReference eventRef = db.collection('events').doc(event.id).update(event.toJson());
  //     log('PHOTOS LENGTH${photos.length.toString()}');
  //
  //     ApiResponse sameImageRespone  =   await saveEventImage(eventRef.path, photos);
  //
  //     if(sameImageRespone.error == false){
  //       eventRef.set(event.copyWith(id: eventRef.id,posterUrl: sameImageRespone.data).toJson());
  //       return ApiResponse(data: event, error: null);
  //
  //
  //     }else{
  //       eventRef.delete();
  //       return ApiResponse(data:sameImageRespone.error , error: 'An error occurred retry');
  //
  //     }
  //     // DocumentReference eventRef = db.collection('events').doc();
  //   } on Exception catch (e) {
  //     return ApiResponse(data: e, error: e.toString());
  //   }
  // }

  //Event endpoints
  Stream<List<EventModel>>? getAllEvents() {
    try {
      return db.collection('events').snapshots().map((event) {
        List<EventModel> myEvent = event.docs.map((e) {
          return EventModel.fromJson(e.data());
        }).toList();
        return myEvent;
      });
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Stream<List<EventModel>>? getUserEvents() {
    try {
      return db
          .collection('events')
          .where('host_id', isEqualTo: _firebaseAuth.currentUser!.uid)
          .snapshots()
          .map((event) {
        List<EventModel> myEvent = event.docs.map((e) {
          return EventModel.fromJson(e.data());
        }).toList();
        return myEvent;
      });
      ;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<ApiResponse> saveEventImage(String id, List<String> photos) async {
    try {
      List<String> images = [];

      for (String photo in photos) {
        var task = await FirebaseStorage.instance
            .ref()
            .child('event_images')
            .child(DateTime.now().toString())
            .putFile(File(photo));
        var url = await task.ref.getDownloadURL();
        log('URL LENGTH${url.length.toString()}');
        images.add(url);
      }

      // await file.delete();
      log('IMAGES LENGTH${images.length.toString()}');
      return ApiResponse(data: images, error: false);
    } on FirebaseException catch (e) {
      debugPrint('Error:${e.code}');
      return ApiResponse(data: e.message, error: true);
    }
  }

  //Tickets endpoints

  Stream<List<TicketModel>>? getUserTickets(String user_id) {
    try {
      return db
          .collection('tickets')
          .where(
            'user_id',
            isEqualTo: user_id,
          )
          .snapshots()
          .map((event) {
        List<TicketModel> myEvent = event.docs.map((e) {
          return TicketModel.fromJson(e.data());
        }).toList();
        return myEvent;
      });
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ApiResponse> scanTickets(EventModel eventModel,String ticket_id) async {
    try {

      WriteBatch batch = db.batch();
      // Create a reference to the document the transaction will use
      DocumentReference documentReference =  db
          .collection('tickets').doc(ticket_id);
      var data ;

    await  documentReference.get().then((value) {
        if(value.exists && value.get('status')== 'paid' && value
            .get('event')['id'] == eventModel.id){
          data = 'Success';
        
            batch.update(documentReference, {'status':'scanned'});



            // return ApiResponse(data: '', error: null);


        }else{

          data = null;


        }

      });


      batch.commit().whenComplete(() =>log('COMMIT COMPLETED') ).then((value) => log('COMMITED'));
      // return ApiResponse(data: '', error: null);

      if(data == null){
        log('FAILED');
        return    ApiResponse(data: null, error: 'Invalid Ticket');
      }else{
        log('SUCCESS');

        return    ApiResponse(data: data, error: null);

      }


      // QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
      //     .collection('tickets')
      //     .where('id', isEqualTo: ticketModel.id)
      //     .where(
      //       'status',
      //       isEqualTo: 'paid',
      //     )
      //     .get();
      //
      // List<TicketModel> docs = querySnapshot.docs.map((e) {
      //   return TicketModel.fromJson(e.data());
      // }).toList();

      // if (docs.isNotEmpty) {
      //   return ApiResponse(data: docs, error: null);
      // } else {
      //   return ApiResponse(data: null, error: 'Invalid Ticket');
      // }
    } on Exception catch (e) {
      log(e.toString());
      return ApiResponse(
          data: null, error: 'Sorry An Error Occurred Please Retry');
    }
  }



  Future<ApiResponse> completeBooking(TicketModel ticketModel) async {
    WriteBatch batch = db.batch();
    try {
      // Create a reference to the document the transaction will use

   DocumentReference ticketsReference =   await db.collection('tickets')
          .doc(ticketModel.id);
   DocumentReference eventsRefrence =   await db.collection('events')
       .doc(ticketModel.event.id);
   DocumentReference usersRefrence =   await db.collection('users')
       .doc(ticketModel.event.hostId);

   batch.update(ticketsReference, {'status':'paid'});



    await eventsRefrence.get().then((value) {
        int currentSize  = value.get('ticket_size');
        List attending = value.get('attending');
         // batch.update(eventsRefrence, {'attending':attending..add(ticketModel.userId)});
         batch.update(eventsRefrence, {'ticket_size':currentSize-1});
   });
   await usersRefrence.get().then((value)  {

int bal = value.get('balance');
batch.update(usersRefrence, {'balance':bal+ticketModel.event.ticketPrice});

   });






          // batch.update(eventsRefrence,{'status': 'paid'});
         await batch.commit().onError((error, stackTrace) => {
            log(error.toString())
          });






   return ApiResponse(data: ticketModel, error: null);


    } on Exception catch (e) {
      log(e.toString());
      return ApiResponse(
          data: null, error: 'Sorry An Error Occurred Please Retry');
    }
  }
}
