import 'package:fitness_tracker/bindings/all_bindings.dart';
import 'package:fitness_tracker/core/singleton.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/pages/bottom_nav/bottom_nav_page.dart';
import 'package:fitness_tracker/services/user_service.dart';

import 'package:fitness_tracker/utils/check_version.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:fitness_tracker/utils/hash_utils.dart';
import 'package:fitness_tracker/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class LoginController extends GetxController {
  RxBool obscurePassword = true.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  final UserService _userService = UserService();

  @override
  void onReady() async {
    super.onReady();
    await checkLogin();
  }

  Future checkLogin() async {
    bool isLogin = await Singleton().isLogin();
    if (isLogin) {
      Get.offAllNamed(BottomNavPage.routeName);
    }
  }

  Future login() async {
    await DialogUtil.showLoading(isClosed: false);
    if (!globalKey.currentState!.validate()) {
      DialogUtil.hideLoading();
      return;
    }
    String passwordHash = HashUtil.hashPassword(passwordController.text);
    try {
      await _userService
          .getUserByUserNameAndPassword(
              username: usernameController.text, password: passwordHash)
          .then(
        (value) async {
          print('Đăng nhập ${value.toString()}');
          Singleton().saveLogin(value!);
          DialogUtil.hideLoading();
          Get.offAndToNamed(BottomNavPage.routeName);
        },
      );
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: '$e');
    }
  }
}
