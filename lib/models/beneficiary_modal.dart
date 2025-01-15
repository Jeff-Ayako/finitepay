// To parse this JSON data, do
//
//     final beneficiaryModal = beneficiaryModalFromJson(jsonString);

import 'dart:convert';

BeneficiaryModal beneficiaryModalFromJson(String str) => BeneficiaryModal.fromJson(json.decode(str));

String beneficiaryModalToJson(BeneficiaryModal data) => json.encode(data.toJson());

class BeneficiaryModal {
    List<Detail> details;

    BeneficiaryModal({
        required this.details,
    });

    factory BeneficiaryModal.fromJson(Map<String, dynamic> json) => BeneficiaryModal(
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
    };
}

class Detail {
    String paymentType;
    String beneficiaryEntityType;
    String? beneficiaryAddress;
    String? beneficiaryCity;
    String? beneficiaryCountry;
    String? beneficiaryFirstName;
    String? beneficiaryLastName;
    String iban;
    String bicSwift;
    String? beneficiaryCompanyName;

    Detail({
        required this.paymentType,
        required this.beneficiaryEntityType,
        this.beneficiaryAddress,
        this.beneficiaryCity,
        this.beneficiaryCountry,
        this.beneficiaryFirstName,
        this.beneficiaryLastName,
        required this.iban,
        required this.bicSwift,
        this.beneficiaryCompanyName,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        paymentType: json["payment_type"],
        beneficiaryEntityType: json["beneficiary_entity_type"],
        beneficiaryAddress: json["beneficiary_address"],
        beneficiaryCity: json["beneficiary_city"],
        beneficiaryCountry: json["beneficiary_country"],
        beneficiaryFirstName: json["beneficiary_first_name"],
        beneficiaryLastName: json["beneficiary_last_name"],
        iban: json["iban"],
        bicSwift: json["bic_swift"],
        beneficiaryCompanyName: json["beneficiary_company_name"],
    );

    Map<String, dynamic> toJson() => {
        "payment_type": paymentType,
        "beneficiary_entity_type": beneficiaryEntityType,
        "beneficiary_address": beneficiaryAddress,
        "beneficiary_city": beneficiaryCity,
        "beneficiary_country": beneficiaryCountry,
        "beneficiary_first_name": beneficiaryFirstName,
        "beneficiary_last_name": beneficiaryLastName,
        "iban": iban,
        "bic_swift": bicSwift,
        "beneficiary_company_name": beneficiaryCompanyName,
    };
}
