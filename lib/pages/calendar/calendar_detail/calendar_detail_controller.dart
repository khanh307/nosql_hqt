import 'dart:ui';

import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/pages/calendar/calendar_controller.dart';
import 'package:fitness_tracker/services/calendar_service.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:get/get.dart';

class CalendarDetailController extends GetxController {
  CalendarModel calendar = Get.arguments;
  final CalendarService _calendarService = CalendarService();
  final UserService _userService = UserService();

  void showDialogConfirmDelete() {
    DialogUtil.showDialog(
        title: 'Xác nhận xóa lịch tập',
        content: const TextWidget(
          text: 'Bạn chắc chắn muốn xóa lịch tập này?',
          textAlign: TextAlign.center,
        ),
        actions: [
          ActionDialog(
            text: 'HỦY',
            onPressed: () {
              Get.back();
            },
          ),
          ActionDialog(
            text: 'OK',
            onPressed: () async {
              Get.back();
              await deleteCalendar();
            },
          )
        ]);
  }

  Future deleteCalendar() async {
    DialogUtil.showLoading();
    // get list student in calendar
    List<StudentModel> students = [];
    for (var user in calendar.calenderStudent!) {
      StudentModel? student = await _userService.getStudentById(user.id!);
      if (student != null) {
        students.add(student);
      }
    }
    await _calendarService.deleteCalendar(calendar: calendar).then(
      (value) async {
        for (var student in students) {
          int index = student.studentCalendar!.indexOf(calendar);
          if (index != -1) {
            student.studentCalendar!.removeAt(index);
            await _userService.updateStudent(studentModel: student);
          }
        }
        DialogUtil.hideLoading();
        DialogUtil.showDialogSuccess(text: 'Xóa thành công', actionClose: () {
          CalendarController.instance.listCalendar.remove(calendar);
          Get.back();
        },);

      },
    );
  }
}
