import 'package:cloud_firestore/cloud_firestore.dart';

class BodyIndicesModel {
  BodyIndicesModel({
    this.id,
    this.bmi,
    this.bodyFat,
    this.height,
    this.muscle,
    this.weight,
    this.date
  });

  BodyIndicesModel.fromJson(dynamic json) {
    id = json['ID'];
    bmi = json['BMI'];
    bodyFat = json['Body_fat'];
    height = json['Height'];
    muscle = json['Muscle'];
    weight = json['Weight'];
    date = json['Date'].toDate();
  }

  String? id;
  num? bmi;
  num? bodyFat;
  num? height;
  num? muscle;
  num? weight;
  DateTime? date;

  BodyIndicesModel copyWith({
    String? id,
    num? bmi,
    num? bodyFat,
    num? height,
    num? muscle,
    num? weight,
    DateTime? date
  }) =>
      BodyIndicesModel(
        id: id ?? this.id,
        bmi: bmi ?? this.bmi,
        bodyFat: bodyFat ?? this.bodyFat,
        height: height ?? this.height,
        muscle: muscle ?? this.muscle,
        weight: weight ?? this.weight,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['BMI'] = bmi;
    map['Body_fat'] = bodyFat;
    map['Height'] = height;
    map['Muscle'] = muscle;
    map['Weight'] = weight;
    map['Date'] = Timestamp.fromDate(date!);
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyIndicesModel &&
          runtimeType == other.runtimeType &&
          date == other.date;

  @override
  int get hashCode => date.hashCode;
}
