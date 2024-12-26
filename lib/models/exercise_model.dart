class ExerciseModel {
  ExerciseModel({
    this.id,
    this.descriptions,
    this.exerciseName,
    this.videos,
  });

  ExerciseModel.fromJson(dynamic json) {
    id = json['ID'];
    descriptions =
        json['Descriptions'] != null ? json['Descriptions'].cast<String>() : [];
    exerciseName = json['Exercise_name'];
    videos = json['Videos'] != null ? json['Videos'].cast<String>() : [];
  }

  String? id;
  List<String>? descriptions;
  String? exerciseName;
  List<String>? videos;

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
    return map;
  }
}
