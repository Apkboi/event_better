part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();
}

class EventsInitial extends EventsState {
  @override
  List<Object> get props => [];
}

class AddEventLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class AddEventFailureState extends EventsState {
 final String error;
  const AddEventFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class AddEventSuccessState extends EventsState {
  final EventModel eventModel;

  const AddEventSuccessState(this.eventModel);

  @override
  List<Object?> get props => [eventModel];

}


class GetAllEventLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class GetAllEventFailureState extends EventsState {
  final String error;
  const GetAllEventFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class GetAllEventFetchedState extends EventsState {
  final List<EventModel> events;

  const GetAllEventFetchedState(this.events);

  @override
  List<Object?> get props => [events];

}


class GetUserEventLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class GetUserEventFailureState extends EventsState {
  final String error;
  const GetUserEventFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class GetUserEventFetchedState extends EventsState {
  final List<EventModel> events;

  const GetUserEventFetchedState(this.events);

  @override
  List<Object?> get props => [events];

}

class BookTicketLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class BookTicketFailureState extends EventsState {
  final String error;
  const BookTicketFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class BookTicketSuccesState extends EventsState {
  final  TicketModel ticket;

  const BookTicketSuccesState(this.ticket);

  @override
  List<Object?> get props => [ticket];

}

class GetUserTicketLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class  GetUserTicketFailureState extends EventsState {
  final String error;
  const GetUserTicketFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class  GetUserTicketFetchedState extends EventsState {
  final  TicketModel ticket;

  const GetUserTicketFetchedState(this.ticket);

  @override
  List<Object?> get props => [ticket];

}

class ScanTicketLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class  ScanTicketFailureState extends EventsState {
  final String error;
  const ScanTicketFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class  ScanTicketSuccesState extends EventsState {
  final  dynamic ticket;

  const ScanTicketSuccesState(this.ticket);

  @override
  List<Object?> get props => [ticket];

}

class CompleteBookingTicketLoadingState extends EventsState {
  @override
  List<Object?> get props => [];

}
class  CompleteBookingTicketFailureState extends EventsState {
  final String error;
  const CompleteBookingTicketFailureState(this.error);

  @override
  List<Object?> get props => [];

}
class  CompleteBookingTicketSuccessState extends EventsState {
  final  TicketModel ticket;

  const CompleteBookingTicketSuccessState(this.ticket);

  @override
  List<Object?> get props => [ticket];

}



