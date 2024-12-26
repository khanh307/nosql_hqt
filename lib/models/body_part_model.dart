import 'exercise_model.dart';

class BodyPartModel {
  BodyPartModel({
    this.id,
    this.departmentName,
    this.departmentImages,
  });

  BodyPartModel.fromJson(dynamic json) {
    id = json['ID'];
    departmentName = json['Department_name'];
    departmentImages = json['Department_images'];
  }

  String? id;
  String? departmentName;
  String? departmentImages;


  BodyPartModel copyWith({
    String? id,
    String? departmentName,
    String? departmentImages,
    List<ExerciseModel>? bodyPartExercise,
  }) =>
      BodyPartModel(
        id: id ?? this.id,
        departmentName: departmentName ?? this.departmentName,
        departmentImages: departmentImages ?? this.departmentImages,

      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Department_name'] = departmentName;
    map['Department_images'] = departmentImages;
    return map;
  }
}
