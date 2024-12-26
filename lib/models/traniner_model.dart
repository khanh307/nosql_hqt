import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/user_model.dart';

class TrainerModel extends UserModel {
  TrainerModel({
    this.id,

    this.usersTraner,
    this.level,
    this.salary,
  });

  TrainerModel.fromJson(dynamic json) {
    id = json['ID'];

    usersTraner = UserModel.fromJson(json['Users_Traner']);
    level = json['level'] != null ? json['level'].cast<String>() : [];
    salary = json['salary'];
  }

  TrainerModel.fromJsonUseDateTime(dynamic json) {
    id = json['ID'];
    usersTraner = UserModel.fromJsonUseDateTime(json['Users_Traner']);
    level = json['level'] != null ? json['level'].cast<String>() : [];
    salary = json['salary'];
  }

  String? id;
  UserModel? usersTraner;
  List<String>? level;
  num? salary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;

    map['Users_Traner'] = usersTraner!.toJson();
    map['level'] = level;
    map['salary'] = salary;
    return map;
  }

  @override
  Map<String, dynamic> toJsonUserDateTime() {
    final map = <String, dynamic>{};
    map['ID'] = id;

    map['Users_Traner'] = usersTraner!.toJsonUserDateTime();
    map['level'] = level;
    map['salary'] = salary;
    return map;
  }
}
