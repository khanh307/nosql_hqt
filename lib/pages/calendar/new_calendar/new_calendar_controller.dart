import 'package:fitness_tracker/bindings/all_bindings.dart';
import 'package:fitness_tracker/models/body_part_model.dart';
import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/pages/calendar/new_calendar/exercise_picker/exercise_picker_page.dart';
import 'package:fitness_tracker/pages/calendar/new_calendar/member_picker/member_picker_page.dart';
import 'package:fitness_tracker/services/body_part_service.dart';
import 'package:fitness_tracker/services/calendar_service.dart';
import 'package:fitness_tracker/services/exercise_service.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/exercise_model.dart';
import '../../../models/student_model.dart';
import '../../../models/user_model.dart';

class NewCalendarController extends GetxController {
  static NewCalendarController get instants => Get.find();
  Rx<DateTime> fromDate = Rx(DateTime.now());
  Rx<DateTime> toDate =
      Rx(DateTime.now().add(const Duration(hours: 1, minutes: 30)));
  Rx<TimeOfDay> fromTime = Rx(TimeOfDay.now());
  Rx<TimeOfDay> toTime = Rx(TimeOfDay.now());
  RxList<ExerciseModel> listExerciseSelected = <ExerciseModel>[].obs;
  Rx<UserModel?> studentSelected = Rx(null);
  RxList<UserModel> listStudent = <UserModel>[].obs;
  final CalendarService _calendarService = CalendarService();
  final UserService _userService = UserService();
  final BodyPartService _bodyPartService = BodyPartService();
  final ExerciseService _exerciseService = ExerciseService();
  List<BodyPartModel> listBodyPart = [];
  Rx<BodyPartModel> bodyPartSelected = Rx(BodyPartModel());
  RxList<ExerciseModel> listExercise = <ExerciseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    toTime.value = TimeOfDay.fromDateTime(toDate.value);
  }

  @override
  void onReady() async {
    super.onReady();
    await getAllBodyPart();
  }

  void changeTime() {
    toTime.value =
        addTime(fromTime.value, const Duration(hours: 1, minutes: 30));
  }

  TimeOfDay addTime(TimeOfDay time, Duration duration) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final newDateTime = dateTime.add(duration);
    return TimeOfDay(hour: newDateTime.hour, minute: newDateTime.minute);
  }

  Future getAllBodyPart() async {
    await DialogUtil.showLoading();
    try {
      var result = await _bodyPartService.getAllBodyPart();
      listBodyPart.addAll(result);
      bodyPartSelected.value = result.first;
      DialogUtil.hideLoading();
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }

  Future getExcercise() async {
    await DialogUtil.showLoading();
    try {
      var result = await _exerciseService.getExerciseByBodyPart(
          bodyPart: bodyPartSelected.value);
      listExercise.addAll(result);
      DialogUtil.hideLoading();
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }

  Future goToMemberPicker() async {
    listStudent.clear();
    Get.toNamed(MemberPickerPage.routeName);
    await _getListMember();
  }

  Future goToExercisePicker() async {
    listExercise.clear();
    Get.toNamed(ExercisePickerPage.routeName);
    await getExcercise();
  }

  Future _getListMember() async {
    DialogUtil.showLoading();
    fromDate.value = fromDate.value.copyWith(
        year: fromDate.value.year,
        month: fromDate.value.month,
        day: fromDate.value.day,
        hour: fromTime.value.hour,
        minute: fromTime.value.minute,
        second: 0,
        microsecond: 0,
        millisecond: 0);
    toDate.value = toDate.value.copyWith(
        year: toDate.value.year,
        month: toDate.value.month,
        day: toDate.value.day,
        hour: toTime.value.hour,
        minute: toTime.value.minute,
        second: 0,
        microsecond: 0,
        millisecond: 0);

    Set<UserModel> student = await _calendarService.getStudentInCalendar(
        startTime: fromDate.value, endTime: toDate.value);
    if (student.isEmpty) {
      print('student empty');
      await _userService.getAllStudent().then(
        (value) {
          for (var student in value) {
            print('student empty }');
            listStudent.add(student.usersStudent!);
          }
          DialogUtil.hideLoading();
        },
      );
    } else {
      print('student not empty');
      await _userService
          .getStudentByIdNotIn(listId: student.map((e) => e.id!).toList())
          .then(
        (value) {
          listStudent.addAll(value);
          DialogUtil.hideLoading();
        },
      );
    }
  }

// Future newCalendar() async {
//   await DialogUtil.showLoading(isClosed: false);
//   if (userSelected.value == null) {
//     DialogUtil.hideLoading();
//     DialogUtil.showDialogWarning(text: 'Vui lòng chọn học viên!');
//     return;
//   }
//   if (listExercise.isEmpty) {
//     DialogUtil.hideLoading();
//     DialogUtil.showDialogWarning(text: 'Vui lòng chọn bài tập');
//     return;
//   }
//   List<double> items = [10, 10, 10];
//   Map<String, List<double>> listExerciseId = {};
//   for (var item in listExercise) {
//     listExerciseId.addAll({item.id!: items});
//   }
//   fromDate.value = fromDate.value.copyWith(
//       year: fromDate.value.year,
//       month: fromDate.value.month,
//       day: fromDate.value.day,
//       hour: fromTime.value.hour,
//       minute: fromTime.value.minute,
//       second: 0,
//       microsecond: 0,
//       millisecond: 0);
//   toDate.value = toDate.value.copyWith(
//       year: toDate.value.year,
//       month: toDate.value.month,
//       day: toDate.value.day,
//       hour: toTime.value.hour,
//       minute: toTime.value.minute,
//       second: 0,
//       microsecond: 0,
//       millisecond: 0);
//   CalendarModel calendar = CalendarModel();
//
//   try {
//     CalendarModel? result =
//         await _calendarService.newCalendar(calendar: calendar);
//     if (result == null) {
//       DialogUtil.hideLoading();
//       DialogUtil.showDialogError(text: 'Lỗi tạo mới lịch');
//     } else {
//       DialogUtil.hideLoading();
//       DialogUtil.showDialogSuccess(
//         text: 'Tạo mới thành công',
//         actionClose: () {},
//       );
//     }
//   } catch (e) {
//     DialogUtil.hideLoading();
//     DialogUtil.showDialogError(text: e.toString());
//   }
// }
}
