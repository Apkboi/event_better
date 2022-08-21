// To parse this JSON data, do
//
//     final checkoutPayload = checkoutPayloadFromJson(jsonString);

import 'dart:convert';

CheckoutPayload checkoutPayloadFromJson(String str) =>
    CheckoutPayload.fromJson(json.decode(str));

String checkoutPayloadToJson(CheckoutPayload data) =>
    json.encode(data.toJson());

class CheckoutPayload {
  CheckoutPayload({
    required this.idempotencyKey,
    required this.merchantSupportEmail,
    required this.askForShippingAddress,
    required this.order,
    required this.redirectUrl,
  });

  String idempotencyKey;
  String merchantSupportEmail;
  bool askForShippingAddress;
  CheckoutPayloadOrder order;
  String redirectUrl;

  factory CheckoutPayload.fromJson(Map<String, dynamic> json) =>
      CheckoutPayload(
        idempotencyKey: json["idempotency_key"],
        merchantSupportEmail: json["merchant_support_email"],
        askForShippingAddress: json["ask_for_shipping_address"],
        order: CheckoutPayloadOrder.fromJson(json["order"]),
        redirectUrl: json["redirect_url"],
      );

  Map<String, dynamic> toJson() => {
        "idempotency_key": idempotencyKey,
        "merchant_support_email": merchantSupportEmail,
        "ask_for_shipping_address": askForShippingAddress,
        "order": order.toJson(),
        "redirect_url": redirectUrl,
      };
}

class CheckoutPayloadOrder {
  CheckoutPayloadOrder({
    required this.idempotencyKey,
    required this.order,
  });

  String idempotencyKey;
  OrderOrder order;

  factory CheckoutPayloadOrder.fromJson(Map<String, dynamic> json) =>
      CheckoutPayloadOrder(
        idempotencyKey: json["idempotency_key"],
        order: OrderOrder.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "idempotency_key": idempotencyKey,
        "order": order.toJson(),
      };
}

class OrderOrder {
  OrderOrder({
    required this.locationId,
    required this.ticketName,
    required this.lineItems,
  });

  String locationId;
  String ticketName;
  List<LineItem> lineItems;

  factory OrderOrder.fromJson(Map<String, dynamic> json) => OrderOrder(
        locationId: json["location_id"],
        ticketName: json["ticket_name"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "ticket_name": ticketName,
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
      };
}

class LineItem {
  LineItem({
    required this.basePriceMoney,
    required this.name,
    required this.quantity,
  });

  BasePriceMoney basePriceMoney;
  String name;
  String quantity;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        basePriceMoney: BasePriceMoney.fromJson(json["base_price_money"]),
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "base_price_money": basePriceMoney.toJson(),
        "name": name,
        "quantity": quantity,
      };
}

class BasePriceMoney {
  BasePriceMoney({
    required this.amount,
    required this.currency,
  });

  int amount;
  String currency;

  factory BasePriceMoney.fromJson(Map<String, dynamic> json) => BasePriceMoney(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}
