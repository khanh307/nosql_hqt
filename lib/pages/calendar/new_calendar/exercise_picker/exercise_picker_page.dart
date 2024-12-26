import 'package:fitness_tracker/models/body_part_model.dart';
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
              Obx(() => DropdownButton<BodyPartModel>(
                    items: controller.listBodyPart
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: ListTile(
                                title: TextWidget(text: e.departmentName ?? ''),
                              )),
                        )
                        .toList(),
                    onChanged: (value) async {
                      controller.bodyPartSelected.value = value!;
                      await controller.getExcercise();
                    },
                    isExpanded: true,
                    hint: const TextWidget(text: 'Chọn bộ phận'),
                    value: controller.bodyPartSelected.value,
                  )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() => ListView.separated(
                    itemBuilder: (context, index) {
                      ExerciseModel model = controller.listExercise[index];
                      return GestureDetector(
                        onTap: () {},
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
                                        height: 50,
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
                                Obx(() =>IconButton(
                                    onPressed: () {
                                      controller.pickerExercise(model);
                                    },
                                    icon: (controller.listExerciseSelected
                                            .contains(model))
                                        ? const Icon(Icons.check_circle, color: Colors.green,)
                                        : const Icon(Icons.add_circle)))
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
