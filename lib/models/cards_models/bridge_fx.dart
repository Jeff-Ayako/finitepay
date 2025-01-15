// To parse this JSON data, do
//
//     final bridgeFxRate = bridgeFxRateFromJson(jsonString);

import 'dart:convert';

BridgeFxRate bridgeFxRateFromJson(String str) => BridgeFxRate.fromJson(json.decode(str));

String bridgeFxRateToJson(BridgeFxRate data) => json.encode(data.toJson());

class BridgeFxRate {
    String status;
    String message;
    Data data;

    BridgeFxRate({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BridgeFxRate.fromJson(Map<String, dynamic> json) => BridgeFxRate(
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
    int ngnUsd;

    Data({
        required this.ngnUsd,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        ngnUsd: json["NGN-USD"],
    );

    Map<String, dynamic> toJson() => {
        "NGN-USD": ngnUsd,
    };
}
