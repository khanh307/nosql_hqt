import 'package:fitness_tracker/core/enum/member_level_enum.dart';
import 'package:fitness_tracker/core/enum/user_type_enum.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:fitness_tracker/utils/hash_utils.dart';
import 'package:fitness_tracker/utils/number_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/traniner_model.dart';
import '../../../models/user_model.dart';

class RegisterController extends GetxController {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  Rx<UserTypeEnum> userTypeSelected = Rx(UserTypeEnum.student);
  RxBool obscurePassword = true.obs;
  RxBool obscureRePassword = true.obs;
  RxBool sexValue = true.obs;
  DateTime? dateSelected;
  RxBool level1 = false.obs;
  RxBool level2 = false.obs;
  RxBool level3 = false.obs;
  RxString memberLevel = MemberLevelEnum.bronze.obs;
  final UserService _userService = UserService();

  @override
  void onReady() async {
    super.onReady();
  }

  Future registerTrainer() async {
    await DialogUtil.showLoading(isClosed: false);
    if (!globalKey.currentState!.validate()) {
      DialogUtil.hideLoading();
      return;
    }

    if (passwordController.text != rePasswordController.text) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogWarning(text: 'Mật khẩu nhập lại không đúng');
      return;
    }
    UserModel user = UserModel(
        name: fullnameController.text,
        birthday: dateSelected ?? DateTime.now(),
        sex: sexValue.value,
        password: HashUtil.hashPassword(rePasswordController.text),
        email: emailController.text,
        phone: usernameController.text);
    List<String> level = [];
    if (level1.value) {
      level.add('Cấp 1');
    }
    if (level2.value) {
      level.add('Cấp 2');
    }
    if (level3.value) {
      level.add('Cấp 3');
    }
    TrainerModel trainerModel = TrainerModel(
        level: level,
        salary: salaryController.text.isNotEmpty
            ? NumberUtils.parseString(salaryController.text)
            : 0,
        usersTraner: user);
    try {
      await _userService.createTrainer(trainer: trainerModel).then((value) {
        DialogUtil.hideLoading();
        if (value) {
          DialogUtil.showDialogSuccess(text: 'Đăng ký thành công');
        } else {
          DialogUtil.showDialogError(text: 'Đăng ký thất bại');
        }
      });
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }

  Future registerStudent() async {
    await DialogUtil.showLoading(isClosed: false);
    if (!globalKey.currentState!.validate()) {
      DialogUtil.hideLoading();
      return;
    }

    if (passwordController.text != rePasswordController.text) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogWarning(text: 'Mật khẩu nhập lại không đúng');
      return;
    }

    UserModel user = UserModel(
        name: fullnameController.text,
        birthday: dateSelected ?? DateTime.now(),
        sex: sexValue.value,
        password: HashUtil.hashPassword(rePasswordController.text),
        email: emailController.text,
        phone: usernameController.text);
    StudentModel studentModel = StudentModel(
        usersStudent: user,
        cardClass: memberLevel.value,
        studentBodyIndices: [],
        studentCalendar: []);
    try {
      await _userService.createStudent(student: studentModel).then((value) {
        DialogUtil.hideLoading();
        if (value) {
          DialogUtil.showDialogSuccess(text: 'Đăng ký thành công');
        } else {
          DialogUtil.showDialogError(text: 'Đăng ký thất bại');
        }
      });
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }
}
