// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';
import '../../models/user_model.dart';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.id,
    required this.eventTheme,
    required this.eventDate,
    required this.attending,
    required this.aboutEvent,
    required this.location,
    required this.ticketSize,
    required this.ticketPrice,
    required this.hostId,
    required this.available_tickets,
    required this.posterUrl,
    required this.host
  });

  String? id;
  String eventTheme;
  DateTime eventDate;
  List<UserModel> attending;
  String aboutEvent;
  String location;
  int ticketSize;
  int ticketPrice;
  int available_tickets;
  String hostId;
 List<dynamic> posterUrl;
  UserModel host;

  EventModel copyWith({
    String? id,
    String? eventTheme,
    DateTime? eventDate,
    List<UserModel>? attending,
    String? aboutEvent,
    String? location,
    int? ticketSize,
    int? ticketPrice,
    int? available_tickets,
    String? hostId,
    List<dynamic>? posterUrl,
     UserModel? host
  }) =>
      EventModel(
        id: id ?? this.id,
        eventTheme: eventTheme ?? this.eventTheme,
        eventDate: eventDate ?? this.eventDate,
        attending: attending ?? this.attending,
        aboutEvent: aboutEvent ?? this.aboutEvent,
        location: location ?? this.location,
        ticketSize: ticketSize ?? this.ticketSize,
        ticketPrice: ticketPrice ?? this.ticketPrice,
        available_tickets: ticketSize ?? this.available_tickets,
        hostId: hostId ?? this.hostId,
        posterUrl: posterUrl ?? this.posterUrl,
        host: host ?? this.host,
      );

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    eventTheme: json["event_theme"],
    eventDate: DateTime.parse(json["event_date"]),
    attending: List<UserModel>.from(json["attending"].map((x) => x)),
    aboutEvent: json["about_event"],
    location: json["location"],
    ticketSize: json["ticket_size"],
    ticketPrice: json["ticket_price"],
    available_tickets: json["available_tickets"],
    hostId: json["host_id"],
    posterUrl: List<String>.from(json["poster_url"].map((x) => x)),
    host: userModelFromJson(json["host"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "event_theme": eventTheme,
    "event_date": eventDate.toIso8601String(),
    "attending": List<dynamic>.from(attending.map((x) => x)),
    "about_event": aboutEvent,
    "location": location,
    "ticket_size": ticketSize,
    "ticket_price": ticketPrice,
    "available_tickets": available_tickets,
    "host_id": hostId,
    "poster_url":List<String>.from(posterUrl.map((x) => x)),
    "host": userModelToJson(host),
  };
}
