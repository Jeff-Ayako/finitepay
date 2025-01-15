// To parse this JSON data, do
//
//     final createContact = createContactFromJson(jsonString);

import 'dart:convert';

CreateContact createContactFromJson(String str) => CreateContact.fromJson(json.decode(str));

String createContactToJson(CreateContact data) => json.encode(data.toJson());

class CreateContact {
    String loginId;
    String id;
    String firstName;
    String lastName;
    String accountId;
    String accountName;
    String status;
    String locale;
    String timezone;
    String emailAddress;
    dynamic mobilePhoneNumber;
    String phoneNumber;
    String yourReference;
    DateTime dateOfBirth;
    DateTime createdAt;
    DateTime updatedAt;

    CreateContact({
        required this.loginId,
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.accountId,
        required this.accountName,
        required this.status,
        required this.locale,
        required this.timezone,
        required this.emailAddress,
        required this.mobilePhoneNumber,
        required this.phoneNumber,
        required this.yourReference,
        required this.dateOfBirth,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CreateContact.fromJson(Map<String, dynamic> json) => CreateContact(
        loginId: json["login_id"],
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        accountId: json["account_id"],
        accountName: json["account_name"],
        status: json["status"],
        locale: json["locale"],
        timezone: json["timezone"],
        emailAddress: json["email_address"],
        mobilePhoneNumber: json["mobile_phone_number"],
        phoneNumber: json["phone_number"],
        yourReference: json["your_reference"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "account_id": accountId,
        "account_name": accountName,
        "status": status,
        "locale": locale,
        "timezone": timezone,
        "email_address": emailAddress,
        "mobile_phone_number": mobilePhoneNumber,
        "phone_number": phoneNumber,
        "your_reference": yourReference,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
