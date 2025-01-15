// To parse this JSON data, do
//
//     final unloadingTranscation = unloadingTranscationFromJson(jsonString);

import 'dart:convert';

UnloadingTranscation unloadingTranscationFromJson(String str) => UnloadingTranscation.fromJson(json.decode(str));

String unloadingTranscationToJson(UnloadingTranscation data) => json.encode(data.toJson());

class UnloadingTranscation {
    String status;
    String message;
    Data data;

    UnloadingTranscation({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UnloadingTranscation.fromJson(Map<String, dynamic> json) => UnloadingTranscation(
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
    String cardId;
    String transactionReference;

    Data({
        required this.cardId,
        required this.transactionReference,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cardId: json["card_id"],
        transactionReference: json["transaction_reference"],
    );

    Map<String, dynamic> toJson() => {
        "card_id": cardId,
        "transaction_reference": transactionReference,
    };
}
