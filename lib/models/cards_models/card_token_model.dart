// To parse this JSON data, do
//
//     final cardTokenModel = cardTokenModelFromJson(jsonString);

import 'dart:convert';

CardTokenModel cardTokenModelFromJson(String str) => CardTokenModel.fromJson(json.decode(str));

String cardTokenModelToJson(CardTokenModel data) => json.encode(data.toJson());

class CardTokenModel {
    String status;
    String message;
    Data data;

    CardTokenModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CardTokenModel.fromJson(Map<String, dynamic> json) => CardTokenModel(
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
    String token;

    Data({
        required this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
