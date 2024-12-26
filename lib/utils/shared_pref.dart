import 'dart:convert';
import 'package:fitness_tracker/core/enum/user_type_enum.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._internal();

  factory SharedPref() {
    return _instance;
  }

  SharedPref._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> getJson(String key) async {
    final SharedPreferences prefs = await _prefs;
    return json.decode(prefs.getString(key)!) ?? '';
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    final isRemember = prefs.getBool(key) ?? false;
    return isRemember;
    // return prefs.getBool(key) ?? false;
  }

  Future setJson(String key, dynamic value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, json.encode(value));
  }

  Future clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  Future remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  Future saveUser(UserModel user) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('user', json.encode(user.toJsonUserDateTime()));
  }

  Future<UserModel?> getUser(String type) async {
    final SharedPreferences prefs = await _prefs;
    String? userString = prefs.getString('user');
    if (userString == null) return null;
    if (type == UserTypeEnum.trainer.value) {
      return TrainerModel.fromJsonUseDateTime(json.decode(userString));
    }
    if (type == UserTypeEnum.student.value) {
      return StudentModel.fromJsonUseDateTime(json.decode(userString));
    }
    return UserModel.fromJsonUseDateTime(json.decode(userString));
  }

  Future saveTypeAccount(String type) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('userType', type);
  }

  Future<String?> getTypeAccount() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userType');
  }
}
