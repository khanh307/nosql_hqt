import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';

class CalendarModel {
  CalendarModel({
    this.id,
    this.endTime,
    this.startTime,
    this.calendarTraner,
    this.calenderStudent,
  });

  CalendarModel.fromJson(dynamic json) {
    id = json['ID'];
    endTime = json['End_time'];
    startTime =
        json['Start_time'] != null ? json['Start_time'].cast<String>() : [];
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
  }

  String? id;
  String? endTime;
  List<String>? startTime;
  List<UserModel>? calendarTraner;
  List<UserModel>? calenderStudent;

  CalendarModel copyWith({
    String? id,
    String? endTime,
    List<String>? startTime,
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
    return map;
  }
}
