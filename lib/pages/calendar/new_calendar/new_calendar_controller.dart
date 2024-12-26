import 'package:fitness_tracker/bindings/all_bindings.dart';
import 'package:fitness_tracker/core/singleton.dart';
import 'package:fitness_tracker/models/body_part_model.dart';
import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/pages/calendar/calendar_controller.dart';
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
  RxList<StudentModel> studentSelected = <StudentModel>[].obs;
  RxList<StudentModel> listStudent = <StudentModel>[].obs;
  final CalendarService _calendarService = CalendarService();
  final UserService _userService = UserService();
  final BodyPartService _bodyPartService = BodyPartService();
  final ExerciseService _exerciseService = ExerciseService();
  List<BodyPartModel> listBodyPart = [];
  Rx<BodyPartModel> bodyPartSelected = Rx(BodyPartModel());
  RxList<ExerciseModel> listExercise = <ExerciseModel>[].obs;
  UserModel user = Singleton().user!;

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
          listStudent.addAll(value);
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

  void pickerExercise(ExerciseModel exercise) {
    if (listExerciseSelected.contains(exercise)) {
      listExerciseSelected.remove(exercise);
    } else {
      listExerciseSelected.add(exercise);
    }
  }

  void pickerStudent(StudentModel student) {
    if (studentSelected.contains(student)) {
      studentSelected.remove(student);
    } else {
      studentSelected.add(student);
    }
    studentSelected.refresh();
  }

  Future newCalendar() async {
    await DialogUtil.showLoading(isClosed: false);
    if (studentSelected.isEmpty) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogWarning(text: 'Vui lòng chọn học viên!');
      return;
    }
    if (listExercise.isEmpty) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogWarning(text: 'Vui lòng chọn bài tập');
      return;
    }

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
    List<UserModel> userSelected = [];
    for (var element in studentSelected) {
      userSelected.add(element.usersStudent!);
    }
    CalendarModel calendar = CalendarModel(
        endTime: toDate.value,
        startTime: fromDate.value,
        calendarExercise: listExerciseSelected,
        calendarTraner: [(user as TrainerModel).usersTraner!],
        calenderStudent: userSelected);
    try {
      CalendarModel? result =
          await _calendarService.createCalendar(calendar: calendar);
      if (result == null) {
        DialogUtil.hideLoading();
        DialogUtil.showDialogError(text: 'Lỗi tạo mới lịch');
      } else {
        DialogUtil.hideLoading();
        for (var element in studentSelected) {
          element.studentCalendar!.add(result);
        }
        await _updateCalendarForStudent(studentSelected);

        DialogUtil.showDialogSuccess(
          text: 'Tạo mới thành công',
          actionClose: () {
            studentSelected.clear();
            listExerciseSelected.clear();
            CalendarController.instance.getCalendar();
          },
        );
      }
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }

  Future _updateCalendarForStudent(List<StudentModel> students) async {
    DialogUtil.showLoading();
    try {
      for (var student in students) {
        await _userService.updateCalendarStudent(studentModel: student);
      }
      DialogUtil.hideLoading();
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }
}
