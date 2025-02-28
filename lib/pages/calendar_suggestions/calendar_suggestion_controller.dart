import 'dart:convert';

import 'package:fitness_tracker/models/exercise_ai_model.dart';
import 'package:fitness_tracker/models/exercise_model.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/services/calendar_service.dart';
import 'package:fitness_tracker/services/exercise_service.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openai_dart/openai_dart.dart';

import '../../core/singleton.dart';
import '../../models/calendar_model.dart';
import '../../models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CalendarSuggestionController extends GetxController {
  RxMap<String, bool> mapThu = <String, bool>{
    'Thứ 2': true,
    'Thứ 3': true,
    'Thứ 4': true,
    'Thứ 5': false,
    'Thứ 6': false,
    'Thứ 7': false,
    'Chủ nhật': false,
  }.obs;

  RxString valueTime = '40 đến 60'.obs;
  RxString useHistory = 'Có'.obs;
  RxMap<String, bool> goal =
      <String, bool>{'Tăng cơ': true, 'Giảm mỡ': false}.obs;
  Rx<TimeOfDay> fromTime = Rx(TimeOfDay.now());
  UserModel user = Singleton().user!;

  final client = OpenAIClient(
      apiKey: dotenv.env['API_KEY_GPT']);
  PageController pageController = PageController(initialPage: 0);

  // final mistralClient = MistralAIClient(
  //   apiKey: 'NT79cmJkgH0WTVru1rlZaBe39ezGoYsb',
  // );

  String amountExercise = '2 - 4';
  final ExerciseService _exerciseService = ExerciseService();
  final CalendarService _calendarService = CalendarService();
  RxMap<String, List<ExerciseModel>> mapExer =
      <String, List<ExerciseModel>>{}.obs;

  Future suggess() async {
    if (!mapThu.containsValue(true)) {
      DialogUtil.showDialogWarning(text: 'Hãy chọn ngày tập luyện');
      return;
    }
    try {
      DialogUtil.showLoading();
      List<ExerciseAIModel> listExercise =
          await _exerciseService.getExerciseForAI();
      List<CalendarModel> history = await _calendarService.getCalendarForStudent(date: DateTime.now(), student: (user as StudentModel).usersStudent!);
      List<String> days = [];
      for (var item in mapThu.keys.toList()) {
        if (mapThu[item] == true) {
          days.add(item);
        }
      }
      List<String> goalString = [];
      for (var item in goal.keys.toList()) {
        if (mapThu[item] == true) {
          goalString.add(item);
        }
      }

      Map<String, List<String>> mapHistory = {};
      for (var calendar in history) {
        String weekdayName = DateUtil.formatThu(calendar.startTime!, false);
        List<String> exerName = [];
        for (var e in calendar.calendarExercise ?? []) {
          exerName.add(e.exerciseName);
        }
        mapHistory[weekdayName] = exerName;
      }

      final prompt = """
           Danh sách bài tập theo nhóm cơ: ${jsonEncode(listExercise)}.
           Số ngày tập của tôi: ${jsonEncode(days)}.
           Thời gian mỗi buổi tập: ${valueTime}.
           Mục tiêu tập luyện: ${goalString}.
           ${(mapHistory.isEmpty) ? '' : 'Lịch sử tập luyện của tôi: $mapHistory'}
           Hãy gợi ý lịch tập gym cho tôi tuần tiếp theo với bài tập cụ thể, lịch tập phải khoa học,
           bài tập theo dạng push day, pull day, leg day hoặc Upper day, Lower day, Full body.
           Không được random bài tập, phải sắp xếp bài tập khoa học.
           Mục tiêu của tôi là tăng cơ.
            Trả về kết quả dưới dạng JSON với cấu trúc:
              {
                "Thứ 2": ["ID bài tập 1", "Id bài tập 2"],
                "Thứ 3": ["ID bài tập 1", "Id bài tập 2"],
                ...
              }
              Chỉ trả về JSON, không có văn bản khác.
            """;

      final res = await client.createChatCompletion(
          request: CreateChatCompletionRequest(
              model: const ChatCompletionModel.modelId('gpt-4o'),
              messages: [
                ChatCompletionMessage.user(
                    content: ChatCompletionUserMessageContent.string(prompt)
                )
              ]));
      final String resultAI = res.choices.first.message.content ?? '';
      if (resultAI.isEmpty) {
        throw Exception('Không khởi tạo được dữ liệu');
      }
      final String resultMap = resultAI.substring(
          resultAI.indexOf('{'), resultAI.lastIndexOf('}') + 1);
      Map<String, List<String>> mapResult =
          (jsonDecode(resultMap) as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, List<String>.from(value)));
      List<ExerciseModel> listExer = await _exerciseService.getAllExer();
      for (var item in mapResult.keys.toList()) {
        List<ExerciseModel> list = [];
        for (var value in mapResult[item] ?? []) {
          ExerciseModel? exercise =
              listExer.firstWhereOrNull((ex) => ex.id == value);
          if (exercise != null) {
            list.add(exercise);
          }
        }
        mapExer[item] = list;
      }
      DialogUtil.hideLoading();
      pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: 'Lỗi trong quá trình thực hiện');
    }
  }

  Future createCalendar() async {
    try {
      DialogUtil.showLoading();
      DateTime now = DateTime.now();
      print('fromTime ${fromTime.value.hour}');
      for (var key in mapExer.keys) {
        DateTime fromDate = getSpecificNextWeekDays(key);
        fromDate.copyWith(
            year: fromDate.year,
            month: fromDate.month,
            day: fromDate.day,
            hour: fromTime.value.hour,
            minute: fromTime.value.minute,
            second: 0,
            microsecond: 0,
            millisecond: 0);
        DateTime toDate;
        switch (valueTime.value) {
          case '30 đến 40':
            toDate = fromDate.add(const Duration(minutes: 40));
            break;
          case '60 đến 80':
            toDate = fromDate.add(const Duration(minutes: 80));
            break;
          case '40 đến 60':
            toDate = fromDate.add(const Duration(minutes: 60));
            break;
          case 'Hơn 1.5 giờ':
            toDate = fromDate.add(const Duration(minutes: 100));
            break;
          default:
            toDate = fromDate.add(const Duration(minutes: 80));
            break;
        }
        List<ExerciseModel> listExer = mapExer[key] ?? [];
        CalendarModel calendar = CalendarModel(
            endTime: toDate,
            startTime: fromDate,
            calendarExercise: listExer,
            calendarTraner: [],
            calenderStudent: [(user as StudentModel).usersStudent!]);
        await _calendarService.createCalendar(calendar: calendar);
      }
      DialogUtil.hideLoading();
      DialogUtil.showDialogSuccess(text: 'Tạo lịch thành công');
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: 'Lỗi $e');
    }
  }

  DateTime getSpecificNextWeekDays(String weekdayName) {
    Map<String, int> weekdayMap = {
      'Thứ 2': 1,
      'Thứ 3': 2,
      'Thứ 4': 3,
      'Thứ 5': 4,
      'Thứ 6': 5,
      'Thứ 7': 6,
      'Chủ nhật': 7,
    };

    DateTime now = DateTime.now();
    DateTime nextMonday = now;
    if (now.weekday >= 1 && now.weekday <= 6) {
      nextMonday = now.add(Duration(days: 8 - now.weekday + 1));
    } else if (now.weekday == 7) {
      nextMonday = now.add(Duration(days: 1));
    }
    if (!weekdayMap.containsKey(weekdayName)) {
      return DateTime.now();
    }

    int weekdayNumber = weekdayMap[weekdayName]!;
    int daysToAdd = weekdayNumber - 2;
    return nextMonday.add(Duration(days: daysToAdd));
  }
}
