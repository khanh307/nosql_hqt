import 'package:fitness_tracker/pages/body_indices/body_indices_controller.dart';
import 'package:fitness_tracker/pages/body_indices/new_indices/new_indices_controller.dart';
import 'package:fitness_tracker/pages/body_part/body_part_controller.dart';
import 'package:fitness_tracker/pages/calendar/calendar_controller.dart';
import 'package:fitness_tracker/pages/calendar/calendar_detail/calendar_detail_controller.dart';
import 'package:get/get.dart';

import '../pages/auth/login/login_controller.dart';
import '../pages/auth/register/register_controller.dart';
import '../pages/bottom_nav/bottom_nav_controller.dart';
import '../pages/calendar/new_calendar/new_calendar_controller.dart';
import '../pages/exercise/exercise_controller.dart';
import '../pages/exercise/exercise_detail/exercise_detail_controller.dart';
import '../pages/member/member_controller.dart';
import '../pages/settings/setting_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => CalendarController());
    Get.lazyPut(() => BodyPartController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => ExerciseController());
    Get.lazyPut(() => ExerciseDetailController());
    Get.lazyPut(() => NewCalendarController());
    Get.lazyPut(() => MemberController());
    Get.lazyPut(() => CalendarDetailController());
    Get.lazyPut(() => BodyIndicesController());
    Get.lazyPut(() => NewIndicesController());
  }
}
