// To parse this JSON data, do
//
//     final exchangeRateModel = exchangeRateModelFromJson(jsonString);

import 'dart:convert';

ExchangeRateModel exchangeRateModelFromJson(String str) => ExchangeRateModel.fromJson(json.decode(str));

String exchangeRateModelToJson(ExchangeRateModel data) => json.encode(data.toJson());

class ExchangeRateModel {
    Rates rates;
    List<dynamic> unavailable;

    ExchangeRateModel({
        required this.rates,
        required this.unavailable,
    });

    factory ExchangeRateModel.fromJson(Map<String, dynamic> json) => ExchangeRateModel(
        rates: Rates.fromJson(json["rates"]),
        unavailable: List<dynamic>.from(json["unavailable"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "rates": rates.toJson(),
        "unavailable": List<dynamic>.from(unavailable.map((x) => x)),
    };
}

class Rates {
    List<String> eurgbp;

    Rates({
        required this.eurgbp,
    });

    factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        eurgbp: List<String>.from(json["EURGBP"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "EURGBP": List<dynamic>.from(eurgbp.map((x) => x)),
    };
}
