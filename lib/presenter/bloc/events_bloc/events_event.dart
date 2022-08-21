part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
}

class AddEventEvent extends EventsEvent{
  final EventModel eventModel;
  final List<String> eventImages;

  AddEventEvent(this.eventModel, this.eventImages);

  @override
  List<Object?> get props => [eventModel];

}
class GetAllEventEvent extends EventsEvent{
  // final List<EventModel> events;

  GetAllEventEvent();

  @override
  List<Object?> get props => [];

}
class GetUserEventEvent extends EventsEvent{
  final String  user_id;


  const GetUserEventEvent(this.user_id);

  @override
  List<Object?> get props => [user_id];

}


class GetEventEvent extends EventsEvent{
  final String  eventId;

  GetEventEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];

}
class AllEventsFetchedEvent extends EventsEvent{
  final List<EventModel> events;


  AllEventsFetchedEvent(this.events);

  @override
  List<Object?> get props => [events];

}



class BookTicketEvent extends EventsEvent{
  final TicketModel  ticket;

  BookTicketEvent(this.ticket);

  @override
  List<Object?> get props => [ticket];

}
class GetUserTickets extends EventsEvent{
  final TicketModel  ticket;
  final String  user_id;

  GetUserTickets({required this.ticket,required this.user_id});

  @override
  List<Object?> get props => [ticket,user_id];

}
class ScanTicketsEvent extends EventsEvent{
  final EventModel eventModel;
  final String  ticket_id;
  // final String  user_id;

  ScanTicketsEvent( {required this.ticket_id,required this.eventModel,});

  @override
  List<Object?> get props => [ticket_id,eventModel];

}
class CompleteBookingTicketEvent extends EventsEvent{
  final TicketModel  ticket;


  CompleteBookingTicketEvent(this.ticket);

  @override
  List<Object?> get props => [ticket];

}






