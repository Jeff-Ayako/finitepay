// To parse this JSON data, do
//
//     final cardHolderCreatedSuccessfully = cardHolderCreatedSuccessfullyFromJson(jsonString);

import 'dart:convert';

CardHolderCreatedSuccessfully cardHolderCreatedSuccessfullyFromJson(String str) => CardHolderCreatedSuccessfully.fromJson(json.decode(str));

String cardHolderCreatedSuccessfullyToJson(CardHolderCreatedSuccessfully data) => json.encode(data.toJson());

class CardHolderCreatedSuccessfully {
    String status;
    String message;
    Data data;

    CardHolderCreatedSuccessfully({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CardHolderCreatedSuccessfully.fromJson(Map<String, dynamic> json) => CardHolderCreatedSuccessfully(
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
    String cardholderId;

    Data({
        required this.cardholderId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cardholderId: json["cardholder_id"],
    );

    Map<String, dynamic> toJson() => {
        "cardholder_id": cardholderId,
    };
}
