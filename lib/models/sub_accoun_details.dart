// To parse this JSON data, do
//
//     final subAccountDetails = subAccountDetailsFromJson(jsonString);

import 'dart:convert';

SubAccountDetails subAccountDetailsFromJson(String str) => SubAccountDetails.fromJson(json.decode(str));

String subAccountDetailsToJson(SubAccountDetails data) => json.encode(data.toJson());

class SubAccountDetails {
    String id;
    String accountName;
    String brand;
    String yourReference;
    String status;
    String street;
    String city;
    String stateOrProvince;
    String country;
    String postalCode;
    String spreadTable;
    String legalEntityType;
    DateTime createdAt;
    DateTime updatedAt;
    String identificationType;
    String identificationValue;
    String shortReference;
    bool apiTrading;
    bool onlineTrading;
    bool phoneTrading;
    bool processThirdPartyFunds;
    String settlementType;
    bool agentOrReliance;
    dynamic termsAndConditionsAccepted;
    String bankAccountVerified;

    SubAccountDetails({
        required this.id,
        required this.accountName,
        required this.brand,
        required this.yourReference,
        required this.status,
        required this.street,
        required this.city,
        required this.stateOrProvince,
        required this.country,
        required this.postalCode,
        required this.spreadTable,
        required this.legalEntityType,
        required this.createdAt,
        required this.updatedAt,
        required this.identificationType,
        required this.identificationValue,
        required this.shortReference,
        required this.apiTrading,
        required this.onlineTrading,
        required this.phoneTrading,
        required this.processThirdPartyFunds,
        required this.settlementType,
        required this.agentOrReliance,
        required this.termsAndConditionsAccepted,
        required this.bankAccountVerified,
    });

    factory SubAccountDetails.fromJson(Map<String, dynamic> json) => SubAccountDetails(
        id: json["id"],
        accountName: json["account_name"],
        brand: json["brand"],
        yourReference: json["your_reference"],
        status: json["status"],
        street: json["street"],
        city: json["city"],
        stateOrProvince: json["state_or_province"],
        country: json["country"],
        postalCode: json["postal_code"],
        spreadTable: json["spread_table"],
        legalEntityType: json["legal_entity_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        identificationType: json["identification_type"],
        identificationValue: json["identification_value"],
        shortReference: json["short_reference"],
        apiTrading: json["api_trading"],
        onlineTrading: json["online_trading"],
        phoneTrading: json["phone_trading"],
        processThirdPartyFunds: json["process_third_party_funds"],
        settlementType: json["settlement_type"],
        agentOrReliance: json["agent_or_reliance"],
        termsAndConditionsAccepted: json["terms_and_conditions_accepted"],
        bankAccountVerified: json["bank_account_verified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "account_name": accountName,
        "brand": brand,
        "your_reference": yourReference,
        "status": status,
        "street": street,
        "city": city,
        "state_or_province": stateOrProvince,
        "country": country,
        "postal_code": postalCode,
        "spread_table": spreadTable,
        "legal_entity_type": legalEntityType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "identification_type": identificationType,
        "identification_value": identificationValue,
        "short_reference": shortReference,
        "api_trading": apiTrading,
        "online_trading": onlineTrading,
        "phone_trading": phoneTrading,
        "process_third_party_funds": processThirdPartyFunds,
        "settlement_type": settlementType,
        "agent_or_reliance": agentOrReliance,
        "terms_and_conditions_accepted": termsAndConditionsAccepted,
        "bank_account_verified": bankAccountVerified,
    };
}
