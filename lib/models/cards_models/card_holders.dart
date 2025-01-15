// To parse this JSON data, do
//
//     final cardHolder = cardHolderFromJson(jsonString);

import 'dart:convert';

CardHolder cardHolderFromJson(String str) => CardHolder.fromJson(json.decode(str));

String cardHolderToJson(CardHolder data) => json.encode(data.toJson());

class CardHolder {
    String status;
    String message;
    Data data;

    CardHolder({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CardHolder.fromJson(Map<String, dynamic> json) => CardHolder(
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
    List<Cardholder> cardholders;
    Meta meta;

    Data({
        required this.cardholders,
        required this.meta,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cardholders: List<Cardholder>.from(json["cardholders"].map((x) => Cardholder.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "cardholders": List<dynamic>.from(cardholders.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class Cardholder {
    Address address;
    String cardholderId;
    int createdAt;
    String emailAddress;
    String firstName;
    IdentityDetails identityDetails;
    bool isActive;
    bool isIdVerified;
    String issuingAppId;
    String lastName;
    String phone;

    Cardholder({
        required this.address,
        required this.cardholderId,
        required this.createdAt,
        required this.emailAddress,
        required this.firstName,
        required this.identityDetails,
        required this.isActive,
        required this.isIdVerified,
        required this.issuingAppId,
        required this.lastName,
        required this.phone,
    });

    factory Cardholder.fromJson(Map<String, dynamic> json) => Cardholder(
        address: Address.fromJson(json["address"]),
        cardholderId: json["cardholder_id"],
        createdAt: json["created_at"],
        emailAddress: json["email_address"],
        firstName: json["first_name"],
        identityDetails: IdentityDetails.fromJson(json["identity_details"]),
        isActive: json["is_active"],
        isIdVerified: json["is_id_verified"],
        issuingAppId: json["issuing_app_id"],
        lastName: json["last_name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "cardholder_id": cardholderId,
        "created_at": createdAt,
        "email_address": emailAddress,
        "first_name": firstName,
        "identity_details": identityDetails.toJson(),
        "is_active": isActive,
        "is_id_verified": isIdVerified,
        "issuing_app_id": issuingAppId,
        "last_name": lastName,
        "phone": phone,
    };
}

class Address {
    String address;
    String city;
    String country;
    String houseNo;
    String postalCode;
    String state;

    Address({
        required this.address,
        required this.city,
        required this.country,
        required this.houseNo,
        required this.postalCode,
        required this.state,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        country: json["country"],
        houseNo: json["house_no"],
        postalCode: json["postal_code"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "country": country,
        "house_no": houseNo,
        "postal_code": postalCode,
        "state": state,
    };
}

class IdentityDetails {
    bool blacklisted;
    DateTime dateOfBirth;
    String firstName;
    String gender;
    String idNo;
    String idType;
    String lastName;
    String phone;

    IdentityDetails({
        required this.blacklisted,
        required this.dateOfBirth,
        required this.firstName,
        required this.gender,
        required this.idNo,
        required this.idType,
        required this.lastName,
        required this.phone,
    });

    factory IdentityDetails.fromJson(Map<String, dynamic> json) => IdentityDetails(
        blacklisted: json["blacklisted"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        firstName: json["first_name"],
        gender: json["gender"],
        idNo: json["id_no"],
        idType: json["id_type"],
        lastName: json["last_name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "blacklisted": blacklisted,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "first_name": firstName,
        "gender": gender,
        "id_no": idNo,
        "id_type": idType,
        "last_name": lastName,
        "phone": phone,
    };
}

class Meta {
    int total;
    int pages;
    dynamic previous;
    dynamic next;

    Meta({
        required this.total,
        required this.pages,
        required this.previous,
        required this.next,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json["total"],
        pages: json["pages"],
        previous: json["previous"],
        next: json["next"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "pages": pages,
        "previous": previous,
        "next": next,
    };
}
