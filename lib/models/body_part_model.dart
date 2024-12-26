import 'exercise_model.dart';

class BodyPartModel {
  BodyPartModel({
    this.id,
    this.departmentName,
    this.departmentImages,
    this.bodyPartExercise,
  });

  BodyPartModel.fromJson(dynamic json) {
    id = json['ID'];
    departmentName = json['Department_name'];
    departmentImages = json['Department_images'];
    if (json['Body_part_Exercise'] != null) {
      bodyPartExercise = [];
      json['Body_part_Exercise'].forEach((v) {
        bodyPartExercise?.add(ExerciseModel.fromJson(v));
      });
    }
  }

  String? id;
  String? departmentName;
  String? departmentImages;
  List<ExerciseModel>? bodyPartExercise;

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
        bodyPartExercise: bodyPartExercise ?? this.bodyPartExercise,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Department_name'] = departmentName;
    map['Department_images'] = departmentImages;
    if (bodyPartExercise != null) {
      map['Body_part_Exercise'] =
          bodyPartExercise?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
