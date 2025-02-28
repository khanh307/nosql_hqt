import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_controller.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/exercise_model.dart';
import '../../../widgets/text_widget.dart';

class EndView extends GetView<CalendarSuggestionController> {
  const EndView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.mapExer.keys.toList().length,
                itemBuilder: (context, index) {
                  String key = controller.mapExer.keys.toList()[index];
                  return itemExercise(key, controller.mapExer[key] ?? []);
                },
              )),
          const SizedBox(height: 10,),
          ButtonWidget(
            text: 'Tạo lịch tập theo gợi ý',
            onPressed: () async {
              await controller.createCalendar();
            },
            isResponsive: true,
          )
        ],
      ),
    );
  }

  Widget itemExercise(String title, List<ExerciseModel> exercises) => Column(
        children: [
          TextWidget(
            text: title,
            fontWeight: FontWeight.bold,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: TextWidget(text: exercises[index].exerciseName ?? ''),
                subtitle: TextWidget(
                  text: exercises[index].bodyPartExercire?.departmentName ?? '',
                  size: 14,
                ),
              );
            },
          )
        ],
      );
}
