import 'package:fitness_tracker/models/body_part_model.dart';

class ExerciseModel {
  ExerciseModel({
    this.id,
    this.descriptions,
    this.exerciseName,
    this.videos,
    this.bodyPartExercire
  });

  ExerciseModel.fromJson(dynamic json) {
    id = json['ID'];
    descriptions =
        json['Descriptions'] != null ? json['Descriptions'].cast<String>() : [];
    exerciseName = json['Exercise_name'];
    videos = json['Videos'] != null ? json['Videos'].cast<String>() : [];
    bodyPartExercire = BodyPartModel.fromJson(json['Body_Part_Exercire']);
  }

  String? id;
  List<String>? descriptions;
  String? exerciseName;
  List<String>? videos;
  BodyPartModel? bodyPartExercire;

  ExerciseModel copyWith({
    String? id,
    List<String>? descriptions,
    String? exerciseName,
    List<String>? videos,
  }) =>
      ExerciseModel(
        id: id ?? this.id,
        descriptions: descriptions ?? this.descriptions,
        exerciseName: exerciseName ?? this.exerciseName,
        videos: videos ?? this.videos,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Descriptions'] = descriptions;
    map['Exercise_name'] = exerciseName;
    map['Videos'] = videos;
    map['Body_Part_Exercire'] = bodyPartExercire?.toJson();
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
