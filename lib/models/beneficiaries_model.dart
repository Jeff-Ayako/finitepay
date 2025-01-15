// To parse this JSON data, do
//
//     final beneficiariesFound = beneficiariesFoundFromJson(jsonString);

import 'dart:convert';

BeneficiariesFound beneficiariesFoundFromJson(String str) => BeneficiariesFound.fromJson(json.decode(str));

String beneficiariesFoundToJson(BeneficiariesFound data) => json.encode(data.toJson());

class BeneficiariesFound {
    List<Beneficiary> beneficiaries;
    Pagination pagination;

    BeneficiariesFound({
        required this.beneficiaries,
        required this.pagination,
    });

    factory BeneficiariesFound.fromJson(Map<String, dynamic> json) => BeneficiariesFound(
        beneficiaries: List<Beneficiary>.from(json["beneficiaries"].map((x) => Beneficiary.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "beneficiaries": List<dynamic>.from(beneficiaries.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class Beneficiary {
    String id;
    String bankAccountHolderName;
    String name;
    dynamic email;
    List<String> paymentTypes;
    List<String> beneficiaryAddress;
    String beneficiaryCountry;
    String beneficiaryEntityType;
    dynamic beneficiaryCompanyName;
    String beneficiaryFirstName;
    String beneficiaryLastName;
    String beneficiaryCity;
    dynamic beneficiaryPostcode;
    dynamic beneficiaryStateOrProvince;
    dynamic beneficiaryDateOfBirth;
    dynamic beneficiaryIdentificationType;
    dynamic beneficiaryIdentificationValue;
    String bankCountry;
    String bankName;
    dynamic bankAccountType;
    String currency;
    String accountNumber;
    dynamic routingCodeType1;
    dynamic routingCodeValue1;
    dynamic routingCodeType2;
    dynamic routingCodeValue2;
    String bicSwift;
    dynamic iban;
    String defaultBeneficiary;
    String creatorContactId;
    List<String> bankAddress;
    dynamic businessNature;
    dynamic companyWebsite;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic beneficiaryExternalReference;

    Beneficiary({
        required this.id,
        required this.bankAccountHolderName,
        required this.name,
        required this.email,
        required this.paymentTypes,
        required this.beneficiaryAddress,
        required this.beneficiaryCountry,
        required this.beneficiaryEntityType,
        required this.beneficiaryCompanyName,
        required this.beneficiaryFirstName,
        required this.beneficiaryLastName,
        required this.beneficiaryCity,
        required this.beneficiaryPostcode,
        required this.beneficiaryStateOrProvince,
        required this.beneficiaryDateOfBirth,
        required this.beneficiaryIdentificationType,
        required this.beneficiaryIdentificationValue,
        required this.bankCountry,
        required this.bankName,
        required this.bankAccountType,
        required this.currency,
        required this.accountNumber,
        required this.routingCodeType1,
        required this.routingCodeValue1,
        required this.routingCodeType2,
        required this.routingCodeValue2,
        required this.bicSwift,
        required this.iban,
        required this.defaultBeneficiary,
        required this.creatorContactId,
        required this.bankAddress,
        required this.businessNature,
        required this.companyWebsite,
        required this.createdAt,
        required this.updatedAt,
        required this.beneficiaryExternalReference,
    });

    factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        id: json["id"],
        bankAccountHolderName: json["bank_account_holder_name"],
        name: json["name"],
        email: json["email"],
        paymentTypes: List<String>.from(json["payment_types"].map((x) => x)),
        beneficiaryAddress: List<String>.from(json["beneficiary_address"].map((x) => x)),
        beneficiaryCountry: json["beneficiary_country"],
        beneficiaryEntityType: json["beneficiary_entity_type"],
        beneficiaryCompanyName: json["beneficiary_company_name"],
        beneficiaryFirstName: json["beneficiary_first_name"],
        beneficiaryLastName: json["beneficiary_last_name"],
        beneficiaryCity: json["beneficiary_city"],
        beneficiaryPostcode: json["beneficiary_postcode"],
        beneficiaryStateOrProvince: json["beneficiary_state_or_province"],
        beneficiaryDateOfBirth: json["beneficiary_date_of_birth"],
        beneficiaryIdentificationType: json["beneficiary_identification_type"],
        beneficiaryIdentificationValue: json["beneficiary_identification_value"],
        bankCountry: json["bank_country"],
        bankName: json["bank_name"],
        bankAccountType: json["bank_account_type"],
        currency: json["currency"],
        accountNumber: json["account_number"],
        routingCodeType1: json["routing_code_type_1"],
        routingCodeValue1: json["routing_code_value_1"],
        routingCodeType2: json["routing_code_type_2"],
        routingCodeValue2: json["routing_code_value_2"],
        bicSwift: json["bic_swift"],
        iban: json["iban"],
        defaultBeneficiary: json["default_beneficiary"],
        creatorContactId: json["creator_contact_id"],
        bankAddress: List<String>.from(json["bank_address"].map((x) => x)),
        businessNature: json["business_nature"],
        companyWebsite: json["company_website"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        beneficiaryExternalReference: json["beneficiary_external_reference"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bank_account_holder_name": bankAccountHolderName,
        "name": name,
        "email": email,
        "payment_types": List<dynamic>.from(paymentTypes.map((x) => x)),
        "beneficiary_address": List<dynamic>.from(beneficiaryAddress.map((x) => x)),
        "beneficiary_country": beneficiaryCountry,
        "beneficiary_entity_type": beneficiaryEntityType,
        "beneficiary_company_name": beneficiaryCompanyName,
        "beneficiary_first_name": beneficiaryFirstName,
        "beneficiary_last_name": beneficiaryLastName,
        "beneficiary_city": beneficiaryCity,
        "beneficiary_postcode": beneficiaryPostcode,
        "beneficiary_state_or_province": beneficiaryStateOrProvince,
        "beneficiary_date_of_birth": beneficiaryDateOfBirth,
        "beneficiary_identification_type": beneficiaryIdentificationType,
        "beneficiary_identification_value": beneficiaryIdentificationValue,
        "bank_country": bankCountry,
        "bank_name": bankName,
        "bank_account_type": bankAccountType,
        "currency": currency,
        "account_number": accountNumber,
        "routing_code_type_1": routingCodeType1,
        "routing_code_value_1": routingCodeValue1,
        "routing_code_type_2": routingCodeType2,
        "routing_code_value_2": routingCodeValue2,
        "bic_swift": bicSwift,
        "iban": iban,
        "default_beneficiary": defaultBeneficiary,
        "creator_contact_id": creatorContactId,
        "bank_address": List<dynamic>.from(bankAddress.map((x) => x)),
        "business_nature": businessNature,
        "company_website": companyWebsite,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "beneficiary_external_reference": beneficiaryExternalReference,
    };
}

class Pagination {
    int totalEntries;
    int totalPages;
    int currentPage;
    int perPage;
    int previousPage;
    int nextPage;
    String order;
    String orderAscDesc;

    Pagination({
        required this.totalEntries,
        required this.totalPages,
        required this.currentPage,
        required this.perPage,
        required this.previousPage,
        required this.nextPage,
        required this.order,
        required this.orderAscDesc,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalEntries: json["total_entries"],
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        perPage: json["per_page"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        order: json["order"],
        orderAscDesc: json["order_asc_desc"],
    );

    Map<String, dynamic> toJson() => {
        "total_entries": totalEntries,
        "total_pages": totalPages,
        "current_page": currentPage,
        "per_page": perPage,
        "previous_page": previousPage,
        "next_page": nextPage,
        "order": order,
        "order_asc_desc": orderAscDesc,
    };
}
