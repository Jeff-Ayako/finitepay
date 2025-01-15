// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

CurrencyModel currencyModelFromJson(String str) => CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel {
    String id;
    String accountId;
    String currency;
    String amount;
    DateTime createdAt;
    DateTime updatedAt;

    CurrencyModel({
        required this.id,
        required this.accountId,
        required this.currency,
        required this.amount,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        id: json["id"],
        accountId: json["account_id"],
        currency: json["currency"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "account_id": accountId,
        "currency": currency,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
