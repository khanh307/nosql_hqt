
import 'package:fitness_tracker/pages/calendar/new_calendar/new_calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/exercise_model.dart';
import '../../../../utils/const/app_colors.dart';
import '../../../../widgets/text_widget.dart';
import '../../../exercise/exercise_detail/exercise_detail_page.dart';

class ExercisePickerPage extends GetView<NewCalendarController> {
  static const String routeName = '/exercisePicker';
  const ExercisePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chọn bài tập'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              DropdownButton(items: [

              ], onChanged: (value) {

              }),

              Expanded(
                child: Obx(() => ListView.separated(
                    itemBuilder: (context, index) {
                      ExerciseModel model = controller.listExercise[index];
                      return GestureDetector(
                        onTap: () {

                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: AppColors.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                        height: 30,
                                      ),
                                      Expanded(
                                        child: TextWidget(
                                          text: model.exerciseName ?? '',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.listExercise.length)),
              )
            ],
          ),
        ));
  }
}
