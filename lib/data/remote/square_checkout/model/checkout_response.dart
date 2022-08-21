// To parse this JSON data, do
//
//     final checkoutResponse = checkoutResponseFromJson(jsonString);

import 'dart:convert';

CheckoutResponse checkoutResponseFromJson(String str) =>
    CheckoutResponse.fromJson(json.decode(str));

String checkoutResponseToJson(CheckoutResponse data) =>
    json.encode(data.toJson());

class CheckoutResponse {
  CheckoutResponse({
    required this.checkout,
  });

  Checkout checkout;

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      CheckoutResponse(
        checkout: Checkout.fromJson(json["checkout"]),
      );

  Map<String, dynamic> toJson() => {
        "checkout": checkout.toJson(),
      };
}

class Checkout {
  Checkout({
    required this.id,
    required this.checkoutPageUrl,
    required this.askForShippingAddress,
    required this.merchantSupportEmail,
    required this.redirectUrl,
    required this.order,
    required this.createdAt,
  });

  String id;
  String checkoutPageUrl;
  bool askForShippingAddress;
  String merchantSupportEmail;
  String redirectUrl;
  Order order;
  DateTime createdAt;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        id: json["id"],
        checkoutPageUrl: json["checkout_page_url"],
        askForShippingAddress: json["ask_for_shipping_address"],
        merchantSupportEmail: json["merchant_support_email"],
        redirectUrl: json["redirect_url"],
        order: Order.fromJson(json["order"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checkout_page_url": checkoutPageUrl,
        "ask_for_shipping_address": askForShippingAddress,
        "merchant_support_email": merchantSupportEmail,
        "redirect_url": redirectUrl,
        "order": order.toJson(),
        "created_at": createdAt.toIso8601String(),
      };
}

class Order {
  Order({
    required this.id,
    required this.locationId,
    required this.source,
    required this.lineItems,
    required this.netAmounts,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.version,
    required this.totalMoney,
    required this.totalTaxMoney,
    required this.totalDiscountMoney,
    required this.totalTipMoney,
    required this.totalServiceChargeMoney,
    required this.ticketName,
    required this.netAmountDueMoney,
    required this.processingModes,
  });

  String id;
  String locationId;
  Source source;
  List<LineItem> lineItems;
  NetAmounts netAmounts;
  DateTime createdAt;
  DateTime updatedAt;
  String state;
  int version;
  Money totalMoney;
  Money totalTaxMoney;
  Money totalDiscountMoney;
  Money totalTipMoney;
  Money totalServiceChargeMoney;
  String ticketName;
  Money netAmountDueMoney;
  ProcessingModes processingModes;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        locationId: json["location_id"],
        source: Source.fromJson(json["source"]),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        netAmounts: NetAmounts.fromJson(json["net_amounts"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        state: json["state"],
        version: json["version"],
        totalMoney: Money.fromJson(json["total_money"]),
        totalTaxMoney: Money.fromJson(json["total_tax_money"]),
        totalDiscountMoney: Money.fromJson(json["total_discount_money"]),
        totalTipMoney: Money.fromJson(json["total_tip_money"]),
        totalServiceChargeMoney:
            Money.fromJson(json["total_service_charge_money"]),
        ticketName: json["ticket_name"],
        netAmountDueMoney: Money.fromJson(json["net_amount_due_money"]),
        processingModes: ProcessingModes.fromJson(json["processing_modes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_id": locationId,
        "source": source.toJson(),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "net_amounts": netAmounts.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "state": state,
        "version": version,
        "total_money": totalMoney.toJson(),
        "total_tax_money": totalTaxMoney.toJson(),
        "total_discount_money": totalDiscountMoney.toJson(),
        "total_tip_money": totalTipMoney.toJson(),
        "total_service_charge_money": totalServiceChargeMoney.toJson(),
        "ticket_name": ticketName,
        "net_amount_due_money": netAmountDueMoney.toJson(),
        "processing_modes": processingModes.toJson(),
      };
}

class LineItem {
  LineItem({
    required this.uid,
    required this.name,
    required this.quantity,
    required this.itemType,
    required this.basePriceMoney,
    required this.variationTotalPriceMoney,
    required this.grossSalesMoney,
    required this.totalTaxMoney,
    required this.totalDiscountMoney,
    required this.totalMoney,
  });

  String uid;
  String name;
  String quantity;
  String itemType;
  Money basePriceMoney;
  Money variationTotalPriceMoney;
  Money grossSalesMoney;
  Money totalTaxMoney;
  Money totalDiscountMoney;
  Money totalMoney;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        uid: json["uid"],
        name: json["name"],
        quantity: json["quantity"],
        itemType: json["item_type"],
        basePriceMoney: Money.fromJson(json["base_price_money"]),
        variationTotalPriceMoney:
            Money.fromJson(json["variation_total_price_money"]),
        grossSalesMoney: Money.fromJson(json["gross_sales_money"]),
        totalTaxMoney: Money.fromJson(json["total_tax_money"]),
        totalDiscountMoney: Money.fromJson(json["total_discount_money"]),
        totalMoney: Money.fromJson(json["total_money"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "quantity": quantity,
        "item_type": itemType,
        "base_price_money": basePriceMoney.toJson(),
        "variation_total_price_money": variationTotalPriceMoney.toJson(),
        "gross_sales_money": grossSalesMoney.toJson(),
        "total_tax_money": totalTaxMoney.toJson(),
        "total_discount_money": totalDiscountMoney.toJson(),
        "total_money": totalMoney.toJson(),
      };
}

class Money {
  Money({
    required this.amount,
    required this.currency,
  });

  int amount;
  String currency;

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
      };
}

// final currencyValues = EnumValues({"USD": Currency.USD});

class NetAmounts {
  NetAmounts({
    required this.totalMoney,
    required this.taxMoney,
    required this.discountMoney,
    required this.tipMoney,
    required this.serviceChargeMoney,
  });

  Money totalMoney;
  Money taxMoney;
  Money discountMoney;
  Money tipMoney;
  Money serviceChargeMoney;

  factory NetAmounts.fromJson(Map<String, dynamic> json) => NetAmounts(
        totalMoney: Money.fromJson(json["total_money"]),
        taxMoney: Money.fromJson(json["tax_money"]),
        discountMoney: Money.fromJson(json["discount_money"]),
        tipMoney: Money.fromJson(json["tip_money"]),
        serviceChargeMoney: Money.fromJson(json["service_charge_money"]),
      );

  Map<String, dynamic> toJson() => {
        "total_money": totalMoney.toJson(),
        "tax_money": taxMoney.toJson(),
        "discount_money": discountMoney.toJson(),
        "tip_money": tipMoney.toJson(),
        "service_charge_money": serviceChargeMoney.toJson(),
      };
}

class ProcessingModes {
  ProcessingModes({
    required this.creationProcessingMode,
  });

  String creationProcessingMode;

  factory ProcessingModes.fromJson(Map<String, dynamic> json) =>
      ProcessingModes(
        creationProcessingMode: json["creation_processing_mode"],
      );

  Map<String, dynamic> toJson() => {
        "creation_processing_mode": creationProcessingMode,
      };
}

class Source {
  Source({
    required this.name,
  });

  String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   // EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
