// To parse this JSON data, do
//
//     final walletBallance = walletBallanceFromJson(jsonString);

import 'dart:convert';

WalletBallance walletBallanceFromJson(String str) => WalletBallance.fromJson(json.decode(str));

String walletBallanceToJson(WalletBallance data) => json.encode(data.toJson());

class WalletBallance {
    String status;
    String message;
    Data data;

    WalletBallance({
        required this.status,
        required this.message,
        required this.data,
    });

    factory WalletBallance.fromJson(Map<String, dynamic> json) => WalletBallance(
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
    String issuingBalanceUsd;

    Data({
        required this.issuingBalanceUsd,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        issuingBalanceUsd: json["issuing_balance_USD"],
    );

    Map<String, dynamic> toJson() => {
        "issuing_balance_USD": issuingBalanceUsd,
    };
}
