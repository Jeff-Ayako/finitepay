// To parse this JSON data, do
//
//     final cardsUnderAccount = cardsUnderAccountFromJson(jsonString);

import 'dart:convert';

CardsUnderAccount cardsUnderAccountFromJson(String str) => CardsUnderAccount.fromJson(json.decode(str));

String cardsUnderAccountToJson(CardsUnderAccount data) => json.encode(data.toJson());

class CardsUnderAccount {
    String status;
    String message;
    Data data;

    CardsUnderAccount({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CardsUnderAccount.fromJson(Map<String, dynamic> json) => CardsUnderAccount(
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
    Meta meta;

    Data({
        required this.cards,
        required this.meta,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class Card {
    BillingAddress billingAddress;
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
    dynamic deletionReason;

    Card({
        required this.billingAddress,
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
        required this.deletionReason,
    });

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
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
        deletionReason: json["deletion_reason"],
    );

    Map<String, dynamic> toJson() => {
        "billing_address": billingAddress.toJson(),
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

class Meta {
    int total;
    int pages;
    dynamic previous;
    dynamic next;

    Meta({
        required this.total,
        required this.pages,
        required this.previous,
        required this.next,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        pages: json["pages"],
        previous: json["previous"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "pages": pages,
        "previous": previous,
        "next": next,
    };
}
