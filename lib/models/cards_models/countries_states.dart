// To parse this JSON data, do
//
//     final countriesStates = countriesStatesFromJson(jsonString);

import 'dart:convert';

CountriesStates countriesStatesFromJson(String str) => CountriesStates.fromJson(json.decode(str));

String countriesStatesToJson(CountriesStates data) => json.encode(data.toJson());

class CountriesStates {
    String status;
    String message;
    Data data;

    CountriesStates({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CountriesStates.fromJson(Map<String, dynamic> json) => CountriesStates(
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
    List<String> states;

    Data({
        required this.states,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        states: List<String>.from(json["states"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x)),
    };
}
