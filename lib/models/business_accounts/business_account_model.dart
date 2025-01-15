// To parse this JSON data, do
//
//     final businessAccountDetails = businessAccountDetailsFromJson(jsonString);

import 'dart:convert';

BusinessAccountDetails businessAccountDetailsFromJson(String str) => BusinessAccountDetails.fromJson(json.decode(str));

String businessAccountDetailsToJson(BusinessAccountDetails data) => json.encode(data.toJson());

class BusinessAccountDetails {
    String status;
    String message;
    Data data;

    BusinessAccountDetails({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BusinessAccountDetails.fromJson(Map<String, dynamic> json) => BusinessAccountDetails(
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
    Account account;

    Data({
        required this.account,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        account: Account.fromJson(json["account"]),
    );

    Map<String, dynamic> toJson() => {
        "account": account.toJson(),
    };
}

class Account {
    String accountId;
    String accountName;
    String accountNumber;
    Balance availableBalance;
    BankAddress bankAddress;
    String bankName;
    Balance bookBalance;
    String currency;
    String holderId;
    String holderType;
    bool isActive;
    bool isLive;
    String issuingAppId;
    String label;
    Limits limits;
    String routingNumber;
    String status;
    String type;

    Account({
        required this.accountId,
        required this.accountName,
        required this.accountNumber,
        required this.availableBalance,
        required this.bankAddress,
        required this.bankName,
        required this.bookBalance,
        required this.currency,
        required this.holderId,
        required this.holderType,
        required this.isActive,
        required this.isLive,
        required this.issuingAppId,
        required this.label,
        required this.limits,
        required this.routingNumber,
        required this.status,
        required this.type,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountId: json["account_id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        availableBalance: Balance.fromJson(json["available_balance"]),
        bankAddress: BankAddress.fromJson(json["bank_address"]),
        bankName: json["bank_name"],
        bookBalance: Balance.fromJson(json["book_balance"]),
        currency: json["currency"],
        holderId: json["holder_id"],
        holderType: json["holder_type"],
        isActive: json["is_active"],
        isLive: json["is_live"],
        issuingAppId: json["issuing_app_id"],
        label: json["label"],
        limits: Limits.fromJson(json["limits"]),
        routingNumber: json["routing_number"],
        status: json["status"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "account_name": accountName,
        "account_number": accountNumber,
        "available_balance": availableBalance.toJson(),
        "bank_address": bankAddress.toJson(),
        "bank_name": bankName,
        "book_balance": bookBalance.toJson(),
        "currency": currency,
        "holder_id": holderId,
        "holder_type": holderType,
        "is_active": isActive,
        "is_live": isLive,
        "issuing_app_id": issuingAppId,
        "label": label,
        "limits": limits.toJson(),
        "routing_number": routingNumber,
        "status": status,
        "type": type,
    };
}

class Balance {
    String currency;
    String value;

    Balance({
        required this.currency,
        required this.value,
    });

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        currency: json["currency"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "value": value,
    };
}

class BankAddress {
    String city;
    String country;
    String line1;
    String line2;
    String postalCode;
    String state;

    BankAddress({
        required this.city,
        required this.country,
        required this.line1,
        required this.line2,
        required this.postalCode,
        required this.state,
    });

    factory BankAddress.fromJson(Map<String, dynamic> json) => BankAddress(
        city: json["city"],
        country: json["country"],
        line1: json["line1"],
        line2: json["line2"],
        postalCode: json["postal_code"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "line1": line1,
        "line2": line2,
        "postal_code": postalCode,
        "state": state,
    };
}

class Limits {
    Receive receive;
    Receive send;

    Limits({
        required this.receive,
        required this.send,
    });

    factory Limits.fromJson(Map<String, dynamic> json) => Limits(
        receive: Receive.fromJson(json["receive"]),
        send: Receive.fromJson(json["send"]),
    );

    Map<String, dynamic> toJson() => {
        "receive": receive.toJson(),
        "send": send.toJson(),
    };
}

class Receive {
    String daily;
    Intrabank intrabank;
    String monthly;

    Receive({
        required this.daily,
        required this.intrabank,
        required this.monthly,
    });

    factory Receive.fromJson(Map<String, dynamic> json) => Receive(
        daily: json["daily"],
        intrabank: Intrabank.fromJson(json["intrabank"]),
        monthly: json["monthly"],
    );

    Map<String, dynamic> toJson() => {
        "daily": daily,
        "intrabank": intrabank.toJson(),
        "monthly": monthly,
    };
}

class Intrabank {
    String daily;
    String monthly;

    Intrabank({
        required this.daily,
        required this.monthly,
    });

    factory Intrabank.fromJson(Map<String, dynamic> json) => Intrabank(
        daily: json["daily"],
        monthly: json["monthly"],
    );

    Map<String, dynamic> toJson() => {
        "daily": daily,
        "monthly": monthly,
    };
}
