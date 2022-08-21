import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:square_tickets/data/remote/events/models/tickets_model.dart';
import 'package:square_tickets/data/remote/models/api_response.dart';
import 'package:square_tickets/data/remote/repository/data_repository.dart';
import '../../../data/remote/events/models/event_model.dart';

part 'events_event.dart';

part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final DataRepository _dataRepository;

  EventsBloc(this._dataRepository) : super(EventsInitial()) {
    on<EventsEvent>((event, emit) {});
    on<AddEventEvent>(_mapAddEventEventToState);
    // on<GetAllEventEvent>(_mapGetAllEventsToState);
    // on<GetUserEventEvent>(_mapGetUserEventsToState);
    on<AllEventsFetchedEvent>(_mapAllEventsFetchedToState);
    on<CompleteBookingTicketEvent>(_mapCompleteBookingEventToState);
    on<ScanTicketsEvent>(_mapScanTicketEventToState);
  }

  FutureOr<void> _mapAddEventEventToState(
      AddEventEvent event, Emitter<EventsState> emit) async {
    emit(AddEventLoadingState());
    try {
      ApiResponse response = await _dataRepository.addEvent(
          event: event.eventModel, photos: event.eventImages);
      log('IMAGES FROM EVENTS ${event.eventImages.toString()}');
      if (response.error == null) {
        emit(AddEventSuccessState(response.data));
      } else {
        emit(AddEventFailureState(response.data));
      }
    } on Exception catch (e) {
      emit(AddEventFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapGetAllEventsToState(
      GetAllEventEvent event, Emitter<EventsState> emit) async {
    emit(GetAllEventLoadingState());
    log('EVENTS LOADING');
    try {
      _dataRepository.getAllEvents()?.listen((event) {
        if (event != null) {
          List<EventModel> myEvent = [];

          // for(QueryDocumentSnapshot<Map<String, dynamic>> event in event.docs ){
          //   myEvent.add(EventModel.fromJson(event.data()));
          //   log(myEvent.length.toString());
          //
          //
          // }

          // add(AllEventsFetchedEvent(event));

          emit(GetAllEventFetchedState(myEvent));
          log('EVENTS FETCHED');
        } else {
          log('EVENTS IS NULL');
        }
      });
    } on Exception catch (e) {
      emit(GetAllEventFailureState(e.toString()));
      log('EVENTS FAILED ${e.toString()}');
    }
  }

  FutureOr<void> _mapAllEventsFetchedToState(
      AllEventsFetchedEvent event, Emitter<EventsState> emit) {
    emit(GetUserEventFetchedState(event.events));
    log('EVENTS LOADING');
  }

  // FutureOr<void> _mapGetUserEventsToState(
  //     GetUserEventEvent event, Emitter<EventsState> emit) {
  //   try {
  //     _dataRepository.getUserEvents(event.user_id)?.listen((event) {
  //       List<EventModel> events = event!.docs.map((e) {
  //
  //         return EventModel.fromJson(e.data()! as Map<String, dynamic>);
  //       }).toList();
  //       emit(GetUserEventFetchedState(events));
  //     });
  //   } on Exception catch (e) {
  //     emit(GetUserEventFailureState(e.toString()));
  //   }
  // }

  FutureOr<void> _mapCompleteBookingEventToState(
      CompleteBookingTicketEvent event, Emitter<EventsState> emit) async {
    emit(CompleteBookingTicketLoadingState());
    try {
      ApiResponse response =
          await _dataRepository.completeBooking(event.ticket);
      if (response.error == null) {
        emit(CompleteBookingTicketSuccessState(response.data));
      } else {
        emit(CompleteBookingTicketFailureState(response.data));
      }
    } on Exception catch (e) {
      emit(CompleteBookingTicketFailureState(e.toString()));
    }
  }

  Future<FutureOr<void>> _mapScanTicketEventToState(
      ScanTicketsEvent event, Emitter<EventsState> emit) async {
    emit(ScanTicketLoadingState());

    try {

      ApiResponse response = await _dataRepository.scanTickets(event.eventModel,event.ticket_id);

      if (response.error == null) {
        emit(ScanTicketSuccesState(response.data));

      } else {
        emit(ScanTicketFailureState(response.data));
      }
    } on Exception catch (e) {
      emit(ScanTicketFailureState(e.toString()));
    }
  }
}
