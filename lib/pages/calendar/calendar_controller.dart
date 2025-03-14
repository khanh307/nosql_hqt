import 'package:calendar_view/calendar_view.dart';
import 'package:fitness_tracker/core/singleton.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/services/calendar_service.dart';
import 'package:fitness_tracker/services/fcm_service.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:get/get.dart';
import '../../models/calendar_model.dart';

import '../../utils/const/app_colors.dart';

class CalendarController extends GetxController {
  static CalendarController get instance => Get.find();
  EventController eventController = EventController();
  Rx<DateTime> dateSelected = Rx(DateTime.now());
  RxList<CalendarModel> listCalendar = <CalendarModel>[].obs;
  List<CalendarEventData<CalendarModel>> events = [];
  final CalendarService _calendarService = CalendarService();
  UserModel user = Singleton().user!;

  @override
  void onReady() async {
    super.onReady();
    await getCalendar();
  }

  Future getCalendar() async {
    listCalendar.clear();
    if (user is TrainerModel) {
      await _getCalendarTrainer();
    } else if (user is StudentModel) {
      print('set calendar student');
      await _getCalendarStudent();
    }
  }

  Future _getCalendarTrainer() async {
    await DialogUtil.showLoading();
    await _calendarService
        .getCalendarForTrainer(
            date: dateSelected.value,
            trainer: (user as TrainerModel).usersTraner!)
        .then(
      (value) {
        listCalendar.addAll(value);
        listCalendar.sort((a, b) => a.startTime!.compareTo(b.startTime!));
        DialogUtil.hideLoading();
      },
    );
  }

  Future _getCalendarStudent() async {
    await DialogUtil.showLoading();
    final now = DateTime.now();
    await _calendarService
        .getCalendarForStudent(
            date: dateSelected.value,
            days: 7,
            student: (user as StudentModel).usersStudent!)
        .then(
      (value) async {
        print('item ${value.length}');
        if (value.isEmpty) {
          await FCMService.scheduleNotificationEveryDay('Tập luyện thôi',
              'Đến giờ tập luyện rồi!', DateTime(2025, 1, 1, 18, 00));
        }
        listCalendar.sort((a, b) => a.startTime!.compareTo(b.startTime!));
        for (var index = 0; index < value.length; index++) {
          var item = value[index];
          print('item ${item.startTime}');
          if (item.startTime!.day == now.day &&
              item.startTime!.month == now.month &&
              item.startTime!.year == now.year) {
            listCalendar.add(item);
          }
          await FCMService.scheduleNotification(item.startTime!.day,
              'Bạn có lịch tập', 'Đến giờ tập luyện rồi!', item.startTime!);
        }
        DialogUtil.hideLoading();
      },
    );
  }

  void addEvent(CalendarModel calendar, int index) {}
}
