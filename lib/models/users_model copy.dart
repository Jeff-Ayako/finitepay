// Package imports:
// ignore_for_file: non_constant_identifier_names


class UserDetails {
  String? uid;
  String? email;
  String? fullname;
  String? phone;
  int? age;
  String? country;
  String? state;
  String? city;


  UserDetails({
    this.uid,
    this.email,
    this.fullname,
    this.phone,
    this.age,
    this.country,
    this.state,
    this.city,
  });

  factory UserDetails.fromMap(map) {
    return UserDetails(
      uid: map['uid'] ?? 'uid',
      email: map['email'] ?? 'email',
      fullname: map['fullname'] ?? 'name',
      phone: map['phone'] ?? 'contact',
      age: map['Age'] ?? 18,
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'phone': phone,
      'age': age,
      'country': country,
      'state': state,
      'city': city,
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


