// To parse this JSON data, do
//
//     final customerCards = customerCardsFromJson(jsonString);

import 'dart:convert';

CustomerCards customerCardsFromJson(String str) =>
    CustomerCards.fromJson(json.decode(str));

String customerCardsToJson(CustomerCards data) => json.encode(data.toJson());

class CustomerCards {
  String status;
  String message;
  Data data;

  CustomerCards({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomerCards.fromJson(Map<String, dynamic> json) => CustomerCards(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<Card> cards;
  int total;

  Data({
    required this.cards,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "total": total,
      };
}

class Card {
  BillingAddress billingAddress;
  bool processing;
  String brand;
  String cardCurrency;
  String cardId;
  String cardName;
  String cardNumber;
  String cardType;
  String cardholderId;
  int createdAt;
  String cvv;
  String expiryMonth;
  String expiryYear;
  bool isActive;
  String issuingAppId;
  String last4;
  bool livemode;
  MetaData metaData;
  dynamic pin3DsActivated;
  bool isDeleted;

  Card({
    required this.billingAddress,
    required this.processing,
    required this.brand,
    required this.cardCurrency,
    required this.cardId,
    required this.cardName,
    required this.cardNumber,
    required this.cardType,
    required this.cardholderId,
    required this.createdAt,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isActive,
    required this.issuingAppId,
    required this.last4,
    required this.livemode,
    required this.metaData,
    required this.pin3DsActivated,
    required this.isDeleted,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
        processing: json["processing"],
        brand: json["brand"],
        cardCurrency: json["card_currency"],
        cardId: json["card_id"],
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        cardType: json["card_type"],
        cardholderId: json["cardholder_id"],
        createdAt: json["created_at"],
        cvv: json["cvv"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        isActive: json["is_active"],
        issuingAppId: json["issuing_app_id"],
        last4: json["last_4"],
        livemode: json["livemode"],
        metaData: MetaData.fromJson(json["meta_data"]),
        pin3DsActivated: json["pin_3ds_activated"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "billing_address": billingAddress.toJson(),
        "processing": processing,
        "brand": brand,
        "card_currency": cardCurrency,
        "card_id": cardId,
        "card_name": cardName,
        "card_number": cardNumber,
        "card_type": cardType,
        "cardholder_id": cardholderId,
        "created_at": createdAt,
        "cvv": cvv,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "is_active": isActive,
        "issuing_app_id": issuingAppId,
        "last_4": last4,
        "livemode": livemode,
        "meta_data": metaData.toJson(),
        "pin_3ds_activated": pin3DsActivated,
        "is_deleted": isDeleted,
      };
}

class BillingAddress {
  String billingAddress1;
  String billingCity;
  String billingCountry;
  String billingZipCode;
  String countryCode;
  String state;
  String stateCode;

  BillingAddress({
    required this.billingAddress1,
    required this.billingCity,
    required this.billingCountry,
    required this.billingZipCode,
    required this.countryCode,
    required this.state,
    required this.stateCode,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        billingAddress1: json["billing_address1"],
        billingCity: json["billing_city"],
        billingCountry: json["billing_country"],
        billingZipCode: json["billing_zip_code"],
        countryCode: json["country_code"],
        state: json["state"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "billing_address1": billingAddress1,
        "billing_city": billingCity,
        "billing_country": billingCountry,
        "billing_zip_code": billingZipCode,
        "country_code": countryCode,
        "state": state,
        "state_code": stateCode,
      };
}

class MetaData {
  String userId;

  MetaData({
    required this.userId,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
