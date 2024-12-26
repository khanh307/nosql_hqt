import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/services/base_service.dart';
import 'package:fitness_tracker/services/constants.dart';

class CalendarService extends BaseService {
  static final CalendarService _instance = CalendarService._internal();

  factory CalendarService() {
    return _instance;
  }

  CalendarService._internal();

  Future<Set<StudentModel>> getStudentInCalendar(
      {required DateTime startTime, required DateTime endTime}) async {
    Set<StudentModel> result = {};
    await firestore
        .collection(Constants.calendarCollection)
        .where(Constants.startTime, isLessThanOrEqualTo: startTime)
        .where(Constants.endTime, isGreaterThanOrEqualTo: endTime)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            CalendarModel calendar = CalendarModel.fromJson(doc.data());
            result.addAll(calendar.calenderStudent ?? []);
          }
        }
      },
    ).onError((error, stackTrace) {
      print('Error: $error');
    },);
    return result;
  }
}
