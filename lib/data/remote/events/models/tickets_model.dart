// To parse this JSON data, do
//
//     final ticketModel = ticketModelFromJson(jsonString);

import 'dart:convert';

import 'package:square_tickets/data/remote/events/models/event_model.dart';

TicketModel ticketModelFromJson(String str) =>
    TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  TicketModel({
    required this.id,
    required this.userId,
    required this.size,
    required this.event,
    required this.created,
    required this.paymentLink,
    required this.status,
    required this.totalPrice,
  });

  String id;
  String userId;
  int size;
  EventModel event;
  DateTime created;
  String paymentLink;
  String status;
  int totalPrice;

  TicketModel copyWith({
    String? id,
    String? userId,
    int? size,
    EventModel? event,
    DateTime? created,
    String? paymentLink,
    String? status,
    int? totalPrice,
  }) =>
      TicketModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        size: size ?? this.size,
        event: event ?? this.event,
        created: created ?? this.created,
        paymentLink: paymentLink ?? this.paymentLink,
        status: status ?? this.status,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json["id"],
        userId: json["user_id"],
        size: json["size"],
        event: EventModel.fromJson(json["event"]),
        created: DateTime.parse(json["created"]),
        paymentLink: json["payment_link"],
        status: json["status"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "size": size,
        "event": event.toJson(),
        "created": created.toIso8601String(),
        "payment_link": paymentLink,
        "status": status,
        "total_price": totalPrice,
      };
}
