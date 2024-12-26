class BodyIndicesModel {
  BodyIndicesModel({
    this.id,
    this.bmi,
    this.bodyFat,
    this.height,
    this.muscle,
    this.weight,
  });

  BodyIndicesModel.fromJson(dynamic json) {
    id = json['ID'];
    bmi = json['BMI'];
    bodyFat = json['Body_fat'];
    height = json['Height'];
    muscle = json['Muscle'];
    weight = json['Weight'];
  }

  String? id;
  num? bmi;
  num? bodyFat;
  num? height;
  num? muscle;
  num? weight;

  BodyIndicesModel copyWith({
    String? id,
    num? bmi,
    num? bodyFat,
    num? height,
    num? muscle,
    num? weight,
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
    return map;
  }
}
