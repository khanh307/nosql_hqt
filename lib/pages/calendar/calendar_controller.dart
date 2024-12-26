import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
import '../../models/calendar_model.dart';

import '../../utils/const/app_colors.dart';

class CalendarController extends GetxController {
  static CalendarController get instance => Get.find();
  EventController eventController = EventController();
  Rx<DateTime> dateSelected = Rx(DateTime.now());
  RxList<CalendarModel> result = <CalendarModel>[].obs;
  List<CalendarEventData<CalendarModel>> events = [];


  @override
  void onReady() async {
    super.onReady();

  }

  Future getCalendar() async {

  }

  void addEvent(CalendarModel calendar, int index) {

  }

}
