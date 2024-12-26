import 'package:fitness_tracker/models/body_indices_model.dart';
import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/user_model.dart';

class StudentModel extends UserModel{
  StudentModel({
    this.id,
    this.cardClass,
    this.studentBodyIndices,
    this.studentCalendar,
    this.usersStudent,
  });

  StudentModel.fromJson(dynamic json) {
    id = json['ID'];
    cardClass = json['Card_class'];
    if (json['Student_Body_Indices'] != null) {
      studentBodyIndices = [];
      json['Student_Body_Indices'].forEach((v) {
        studentBodyIndices?.add(BodyIndicesModel.fromJson(v));
      });
    }
    if (json['Student_Calendar'] != null) {
      studentCalendar = [];
      json['Student_Calendar'].forEach((v) {
        studentCalendar?.add(CalendarModel.fromJson(v));
      });
    }

    usersStudent = UserModel.fromJson(json['Users_Student']);
  }

  StudentModel.fromJsonUseDateTime(dynamic json) {
    id = json['ID'];
    cardClass = json['Card_class'];
    if (json['Student_Body_Indices'] != null) {
      studentBodyIndices = [];
      json['Student_Body_Indices'].forEach((v) {
        studentBodyIndices?.add(BodyIndicesModel.fromJson(v));
      });
    }
    if (json['Student_Calendar'] != null) {
      studentCalendar = [];
      json['Student_Calendar'].forEach((v) {
        studentCalendar?.add(CalendarModel.fromJson(v));
      });
    }
    usersStudent = UserModel.fromJsonUseDateTime(json['Users_Student']);
  }

  String? id;
  String? cardClass;
  List<BodyIndicesModel>? studentBodyIndices;
  List<CalendarModel>? studentCalendar;
  UserModel? usersStudent;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Card_class'] = cardClass;
    if (studentBodyIndices != null) {
      map['Student_Body_Indices'] =
          studentBodyIndices?.map((v) => v.toJson()).toList();
    }
    if (studentCalendar != null) {
      map['Student_Calendar'] =
          studentCalendar?.map((v) => v.toJson()).toList();
    }
    map['Users_Student'] = usersStudent!.toJson();
    return map;
  }

  Map<String, dynamic> toJsonUserDateTime() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Card_class'] = cardClass;
    if (studentBodyIndices != null) {
      map['Student_Body_Indices'] =
          studentBodyIndices?.map((v) => v.toJson()).toList();
    }
    if (studentCalendar != null) {
      map['Student_Calendar'] =
          studentCalendar?.map((v) => v.toJson()).toList();
    }
    map['Users_Student'] = usersStudent!.toJsonUserDateTime();
    return map;
  }
}
