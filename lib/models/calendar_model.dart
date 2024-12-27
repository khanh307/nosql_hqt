import 'package:fitness_tracker/models/exercise_model.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';

class CalendarModel {
  CalendarModel(
      {this.id,
      this.endTime,
      this.startTime,
      this.calendarTraner,
      this.calenderStudent,
      this.calendarExercise});

  CalendarModel.fromJson(dynamic json) {
    id = json['ID'];
    endTime = json['End_time'].toDate();
    startTime = json['Start_time'].toDate();
    if (json['Calendar_Traner'] != null) {
      calendarTraner = [];
      json['Calendar_Traner'].forEach((v) {
        calendarTraner?.add(UserModel.fromJson(v));
      });
    }
    if (json['Calender_Student'] != null) {
      calenderStudent = [];
      json['Calender_Student'].forEach((v) {
        calenderStudent?.add(UserModel.fromJson(v));
      });
    }
    if (json['Calendar_Exercise'] != null) {
      calendarExercise = [];
      json['Calendar_Exercise'].forEach((v) {
        calendarExercise?.add(ExerciseModel.fromJson(v));
      });
    }
  }

  String? id;
  DateTime? endTime;
  DateTime? startTime;
  List<UserModel>? calendarTraner;
  List<UserModel>? calenderStudent;
  List<ExerciseModel>? calendarExercise;

  CalendarModel copyWith({
    String? id,
    DateTime? endTime,
    DateTime? startTime,
    List<UserModel>? calendarTraner,
    List<UserModel>? calenderStudent,
  }) =>
      CalendarModel(
        id: id ?? this.id,
        endTime: endTime ?? this.endTime,
        startTime: startTime ?? this.startTime,
        calendarTraner: calendarTraner ?? this.calendarTraner,
        calenderStudent: calenderStudent ?? this.calenderStudent,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['End_time'] = endTime;
    map['Start_time'] = startTime;
    if (calendarTraner != null) {
      map['Calendar_Traner'] = calendarTraner?.map((v) => v.toJson()).toList();
    }
    if (calenderStudent != null) {
      map['Calender_Student'] =
          calenderStudent?.map((v) => v.toJson()).toList();
    }
    if (calendarExercise != null) {
      map['Calendar_Exercise'] =
          calendarExercise?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  Map<String, dynamic> toJsonForStudent() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['End_time'] = endTime;
    map['Start_time'] = startTime;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
