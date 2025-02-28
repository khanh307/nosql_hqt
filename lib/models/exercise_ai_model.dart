import 'package:fitness_tracker/models/body_part_model.dart';

class ExerciseAIModel {
  ExerciseAIModel({this.id, this.exerciseName, this.bodyPartName});

  ExerciseAIModel.fromJson(dynamic json) {
    id = json['ID'];
    exerciseName = json['Exercise_name'];
    var bodyPartExercire = BodyPartModel.fromJson(json['Body_Part_Exercire']);
    bodyPartName = bodyPartExercire.departmentName;
  }

  String? id;
  String? exerciseName;
  String? bodyPartName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Exercise_name'] = exerciseName;
    map['Body_Part_Name'] = bodyPartName;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAIModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
