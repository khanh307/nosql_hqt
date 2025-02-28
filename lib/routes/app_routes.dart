import 'package:fitness_tracker/pages/body_indices/body_indices_page.dart';
import 'package:fitness_tracker/pages/body_indices/new_indices/new_indices_page.dart';
import 'package:fitness_tracker/pages/body_part/body_part_page.dart';
import 'package:fitness_tracker/pages/calendar/calendar_detail/calendar_detail_page.dart';
import 'package:fitness_tracker/pages/calendar/calendar_page.dart';
import 'package:fitness_tracker/pages/calendar/new_calendar/exercise_picker/exercise_picker_page.dart';
import 'package:fitness_tracker/pages/calendar/new_calendar/member_picker/member_picker_page.dart';
import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_page.dart';
import 'package:fitness_tracker/pages/menu_suggestions/menu_suggestions_page.dart';
import 'package:get/get.dart';

import '../bindings/all_bindings.dart';
import '../pages/auth/login/login_page.dart';
import '../pages/auth/register/register_page.dart';
import '../pages/bottom_nav/bottom_nav_page.dart';
import '../pages/calendar/new_calendar/new_calendar_page.dart';
import '../pages/exercise/exercise_detail/exercise_detail_page.dart';
import '../pages/exercise/exercise_page.dart';
import '../pages/member/member_page.dart';
import '../pages/settings/setting_page.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => const LoginPage(), binding: AllBindings()),
    GetPage(
        name: '/login', page: () => const LoginPage(), binding: AllBindings()),
    GetPage(
      name: RegisterPage.routeName,
      page: () => const RegisterPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: BottomNavPage.routeName,
      page: () => const BottomNavPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: CalendarPage.routeName,
      page: () => const CalendarPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: BodyPartPage.routeName,
      page: () => const BodyPartPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: SettingPage.routeName,
      page: () => const SettingPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: ExercisePage.routeName,
      page: () => const ExercisePage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: ExerciseDetailPage.routeName,
      page: () => const ExerciseDetailPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: NewCalendarPage.routeName,
      page: () => const NewCalendarPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: MemberPage.routeName,
      page: () => const MemberPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: MemberPickerPage.routeName,
      page: () => const MemberPickerPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: ExercisePickerPage.routeName,
      page: () => const ExercisePickerPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: CalendarDetailPage.routeName,
      page: () => const CalendarDetailPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: BodyIndicesPage.routeName,
      page: () => const BodyIndicesPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: NewIndicesPage.routeName,
      page: () => const NewIndicesPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: CalendarSuggestionPage.routeName,
      page: () => const CalendarSuggestionPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: MenuSuggestionsPage.routeName,
      page: () => const MenuSuggestionsPage(),
      binding: AllBindings(),
      transition: Transition.rightToLeft,
    ),
  ];
}
