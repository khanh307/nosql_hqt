import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/services/base_service.dart';
import 'package:fitness_tracker/services/constants.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import '../utils/app_exceptions.dart';
import '../utils/utils.dart';

class CalendarService extends BaseService {
  static final CalendarService _instance = CalendarService._internal();

  factory CalendarService() {
    return _instance;
  }

  CalendarService._internal();

  Future<Set<UserModel>> getStudentInCalendar(
      {required DateTime startTime, required DateTime endTime}) async {
    Set<UserModel> result = {};
    await firestore
        .collection(Constants.calendarCollection)
        .where(Constants.startTime, isLessThanOrEqualTo: endTime)
        .where(Constants.endTime, isGreaterThanOrEqualTo: startTime)
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
      throw BadRequestException(error.toString());
    });

    await firestore
        .collection(Constants.calendarCollection)
        .where(Constants.startTime, isLessThanOrEqualTo: endTime)
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
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<CalendarModel?> createCalendar(
      {required CalendarModel calendar}) async {
    CalendarModel? result;
    String uuid = Utils.generateUUID();
    calendar.id = uuid;
    await firestore
        .collection(Constants.calendarCollection)
        .doc(uuid)
        .set(calendar.toJson())
        .then(
      (value) async {
        result = calendar;
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<bool?> deleteCalendar(
      {required CalendarModel calendar}) async {
    bool result = false;
    await firestore
        .collection(Constants.calendarCollection)
        .doc(calendar.id)
        .delete()
        .then(
          (value) async {
        result = true;
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<List<CalendarModel>> getCalendarForTrainer(
      {required DateTime date, required UserModel trainer}) async {
    DateTime startOfDay = date.copyWith(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0);
    DateTime endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(microseconds: 1));
    List<CalendarModel> result = [];
    await firestore
        .collection(Constants.calendarCollection)
        .where(Constants.calendarTraner, arrayContains: trainer.toJson())
        .where(Constants.startTime, isGreaterThanOrEqualTo: startOfDay)
        .where(Constants.startTime, isLessThanOrEqualTo: endOfDay)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(CalendarModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }


  Future<List<CalendarModel>> getCalendarForStudent(
      {required DateTime date, required UserModel student, int days = 1}) async {
    DateTime startOfDay = date.copyWith(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0);
    DateTime endOfDay = startOfDay
        .add(Duration(days: days))
        .subtract(const Duration(microseconds: 1));
    List<CalendarModel> result = [];
    print('startOfDay $startOfDay -- endOfDay $endOfDay');
    await firestore
        .collection(Constants.calendarCollection)
        .where(Constants.calendarStudent, arrayContains: student.toJson())
        .where(Constants.startTime, isGreaterThanOrEqualTo: startOfDay)
        .where(Constants.startTime, isLessThanOrEqualTo: endOfDay)
        .get()
        .then(
          (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(CalendarModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }
}
