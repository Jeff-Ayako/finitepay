// Package imports:
// ignore_for_file: non_constant_identifier_names

class UserDetails {
  bool? onboardingDone;
  String? uid;
  String? email;
  String? fullname;
  String? phone;
  int? age;
  String? country;
  String? state;
  String? city;
  String? businessName;
  String? registrationType;
  String? dob;
  String? currencyKey;

  String? nationalID;
  String? postalCode;

  String? firstName;
  String? lastName;

  UserDetails({
    this.onboardingDone,
    this.uid,
    this.email,
    this.fullname,
    this.phone,
    this.age,
    this.country,
    this.state,
    this.city,
    this.businessName,
    this.dob,
    this.firstName,
    this.lastName,
    this.nationalID,
    this.postalCode,
    this.registrationType,
    this.currencyKey,
  });

  factory UserDetails.fromMap(map) {
    return UserDetails(
      onboardingDone: map['onboardingDone'] ?? '',
      uid: map['uid'] ?? 'uid',
      email: map['email'] ?? 'email',
      fullname: map['fullname'] ?? 'name',
      phone: map['phone'] ?? 'contact',
      age: map['Age'] ?? 18,
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      businessName: map['businessName'] ?? '',
      dob: map['dob'] ?? '1999-01-01',
      firstName: map['firstName'] ?? 'User',
      lastName: map['lastName'] ?? 'User',
      nationalID: map['nationalID'] ?? '',
      postalCode: map['postalCode'] ?? '',
      registrationType: map['registrationType'] ?? '',
      currencyKey: map['currencyKey'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onboardingDone': onboardingDone,
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'phone': phone,
      'age': age,
      'country': country,
      'state': state,
      'city': city,
      'businessName': businessName,
      'dob': dob,
      'firstName': firstName,
      'lastName': lastName,
      'nationalID': nationalID,
      'postalCode': postalCode,
      'registrationType': registrationType,
      'currencyKey': currencyKey,
    };
  }
}

class Notifs {
  String? type;
  String? title;
  String? body;
  String? serverdate;
  DateTime? datenow;
  String? checked;

  Notifs(
      {this.type,
      this.title,
      this.body,
      this.serverdate,
      this.datenow,
      this.checked});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'body': body,
      'date': serverdate,
      'datenow': datenow,
      'checked': checked,
    };
  }
}
