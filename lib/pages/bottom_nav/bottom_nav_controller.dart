import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fitness_tracker/core/singleton.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/pages/body_part/body_part_page.dart';
import 'package:fitness_tracker/pages/calendar/calendar_page.dart';
import 'package:fitness_tracker/pages/member/member_page.dart';
import 'package:fitness_tracker/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/const/app_colors.dart';
import '../settings/setting_page.dart';

class BottomNavController extends GetxController {
  static BottomNavController get instants => Get.find();
  RxInt selectedIndex = 0.obs;
  late PageController pageController = PageController();
  UserModel user = Singleton().user!;

  late List<Widget> pages = [
    const CalendarPage(),
    const MemberPage(),
    const BodyPartPage(),
    const SettingPage(),
  ];

  RxList<BottomNavyBarItem> items = [
    BottomNavyBarItem(
        icon: const Icon(Icons.calendar_month),
        inactiveColor: AppColors.textGrey,
        title: const Text('Lịch'),
        activeColor: AppColors.primaryColor,
        textAlign: TextAlign.center),
    BottomNavyBarItem(
      icon: const Icon(Icons.supervised_user_circle_outlined),
      inactiveColor: AppColors.textGrey,
      title: const Text('Học viên'),
      textAlign: TextAlign.center,
      activeColor: AppColors.primaryColor,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.play_lesson_outlined),
      inactiveColor: AppColors.textGrey,
      title: const Text('Bài tập'),
      textAlign: TextAlign.center,
      activeColor: AppColors.primaryColor,
    ),
    BottomNavyBarItem(
        icon: const Icon(Icons.settings),
        inactiveColor: AppColors.textGrey,
        title: const Text('Cài đặt'),
        activeColor: AppColors.primaryColor,
        textAlign: TextAlign.center),
  ].obs;

  @override
  void onInit() async {
    super.onInit();
    if (user is TrainerModel) {
      print('Đăng nhập trainer');
    } else if (user is StudentModel) {
      print('Đăng nhập student');
    } else {
      print('Đăng nhập admin');
    }
  }
}
