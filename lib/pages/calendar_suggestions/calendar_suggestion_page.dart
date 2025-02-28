import 'package:fitness_tracker/models/exercise_model.dart';
import 'package:fitness_tracker/pages/calendar_suggestions/page_view/day_view.dart';
import 'package:fitness_tracker/pages/calendar_suggestions/page_view/end_view.dart';
import 'package:fitness_tracker/pages/calendar_suggestions/page_view/history_view.dart';
import 'package:fitness_tracker/pages/calendar_suggestions/page_view/intro_view.dart';
import 'package:fitness_tracker/pages/calendar_suggestions/page_view/time_view.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/dropdown_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calendar_suggestion_controller.dart';

class CalendarSuggestionPage extends GetView<CalendarSuggestionController> {
  static const String routeName = '/calendarSuggestion';

  const CalendarSuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gợi ý lịch tập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: PageView(
          controller: controller.pageController,
          children: const [IntroView(), DayView(), TimeView(), HistoryView(), EndView()],
        ),
      ),
    );
  }


}
