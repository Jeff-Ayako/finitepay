// To parse this JSON data, do
//
//     final actualCardDetails = actualCardDetailsFromJson(jsonString);

import 'dart:convert';

ActualCardDetails actualCardDetailsFromJson(String str) =>
    ActualCardDetails.fromJson(json.decode(str));

String actualCardDetailsToJson(ActualCardDetails data) =>
    json.encode(data.toJson());

class ActualCardDetails {
  String status;
  String message;
  Data data;

  ActualCardDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ActualCardDetails.fromJson(Map<String, dynamic> json) =>
      ActualCardDetails(
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
  BillingAddress billingAddress;
  bool blockedDueToFraud;
  String brand;
  String cardCurrency;
  String cardId;
  String cardName;
  String cardNumber;
  String cardType;
  String cardholderId;
  int createdAt;
  String currentCardLimit;
  String cvv;
  String expiryMonth;
  String expiryYear;
  bool isActive;
  bool isDeleted;
  String issuingAppId;
  String last4;
  bool livemode;
  MetaData metaData;
  dynamic insufficientFundsDeclineCount;
  String balance;
  String availableBalance;
  String bookBalance;
  dynamic deletionReason;

  Data({
    required this.billingAddress,
    required this.blockedDueToFraud,
    required this.brand,
    required this.cardCurrency,
    required this.cardId,
    required this.cardName,
    required this.cardNumber,
    required this.cardType,
    required this.cardholderId,
    required this.createdAt,
    required this.currentCardLimit,
    required this.cvv,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isActive,
    required this.isDeleted,
    required this.issuingAppId,
    required this.last4,
    required this.livemode,
    required this.metaData,
    required this.insufficientFundsDeclineCount,
    required this.balance,
    required this.availableBalance,
    required this.bookBalance,
    required this.deletionReason,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
        blockedDueToFraud: json["blocked_due_to_fraud"],
        brand: json["brand"],
        cardCurrency: json["card_currency"],
        cardId: json["card_id"],
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        cardType: json["card_type"],
        cardholderId: json["cardholder_id"],
        createdAt: json["created_at"],
        currentCardLimit: json["current_card_limit"],
        cvv: json["cvv"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        issuingAppId: json["issuing_app_id"],
        last4: json["last_4"],
        livemode: json["livemode"],
        metaData: MetaData.fromJson(json["meta_data"]),
        insufficientFundsDeclineCount: json["insufficient_funds_decline_count"],
        balance: json["balance"],
        availableBalance: json["available_balance"],
        bookBalance: json["book_balance"],
        deletionReason: json["deletion_reason"],
      );

  Map<String, dynamic> toJson() => {
        "billing_address": billingAddress.toJson(),
        "blocked_due_to_fraud": blockedDueToFraud,
        "brand": brand,
        "card_currency": cardCurrency,
        "card_id": cardId,
        "card_name": cardName,
        "card_number": cardNumber,
        "card_type": cardType,
        "cardholder_id": cardholderId,
        "created_at": createdAt,
        "current_card_limit": currentCardLimit,
        "cvv": cvv,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "issuing_app_id": issuingAppId,
        "last_4": last4,
        "livemode": livemode,
        "meta_data": metaData.toJson(),
        "insufficient_funds_decline_count": insufficientFundsDeclineCount,
        "balance": balance,
        "available_balance": availableBalance,
        "book_balance": bookBalance,
        "deletion_reason": deletionReason,
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
