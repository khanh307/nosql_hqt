import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.id,
    this.birthday,
    this.email,
    this.name,
    this.password,
    this.phone,
    this.sex,
    this.token
  });

  UserModel.fromJson(dynamic json) {
    id = json['ID'];
    birthday = json['Birthday'].toDate();
    email = json['Email'];
    name = json['Name'];
    password = json['Password'];
    phone = json['Phone'];
    sex = json['Sex'];
    token = json['Token'];
  }

  UserModel.fromJsonUseDateTime(dynamic json) {
    id = json['ID'];
    birthday = DateTime.parse(json['Birthday']);
    email = json['Email'];
    name = json['Name'];
    password = json['Password'];
    phone = json['Phone'];
    sex = json['Sex'];
    token = json['Token'];
  }

  String? id;
  DateTime? birthday;
  String? email;
  String? name;
  String? password;
  String? phone;
  bool? sex;
  String? token;

  UserModel copyWith({
    String? id,
    DateTime? birthday,
    String? email,
    String? name,
    String? password,
    String? phone,
    bool? sex,
  }) =>
      UserModel(
        birthday: birthday ?? this.birthday,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        sex: sex ?? this.sex,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Birthday'] = Timestamp.fromDate(birthday!);
    map['Email'] = email;
    map['Name'] = name;
    map['Password'] = password;
    map['Phone'] = phone;
    map['Sex'] = sex;
    map['Token'] = token;
    return map;
  }

  Map<String, dynamic> toJsonUserDateTime() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Birthday'] = birthday!.toIso8601String();
    map['Email'] = email;
    map['Name'] = name;
    map['Password'] = password;
    map['Phone'] = phone;
    map['Sex'] = sex;
    map['Token'] = token;
    return map;
  }


  @override
  String toString() {
    return 'UserModel{id: $id}';
  }
}
