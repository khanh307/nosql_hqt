import 'package:fitness_tracker/core/enum/user_type_enum.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/utils/shared_pref.dart';
import 'package:get/get.dart';
import 'package:fitness_tracker/models/user_model.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  UserModel? user;
  late SharedPref prefs;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  initial() async {
    prefs = SharedPref();
  }

  Future<bool> isLogin() async {
    final String? type = await prefs.getTypeAccount();
    if (type == null) return false;
    final UserModel? user = await prefs.getUser(type);
    if (user != null) {
      this.user = user;
      return true;
    } else {
      return false;
    }
  }

  Future saveLogin(UserModel user) async {
    this.user = user;
    if (user is TrainerModel) {
      await prefs.saveTypeAccount(UserTypeEnum.trainer.value);
    } else if (user is StudentModel) {
      await prefs.saveTypeAccount(UserTypeEnum.student.value);
    } else {
      await prefs.saveTypeAccount(UserTypeEnum.admin.value);
    }
    await prefs.saveUser(user);
  }

  Future logout() async {
    user = null;
    await prefs.clear();
  }
}
