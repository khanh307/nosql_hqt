import 'dart:typed_data';

import 'package:fitness_tracker/models/exercise_model.dart';
import 'package:fitness_tracker/pages/exercise/exercise_controller.dart';
import 'package:fitness_tracker/pages/exercise/exercise_detail/exercise_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/const/app_colors.dart';
import '../../widgets/responsive_frame.dart';
import '../../widgets/text_widget.dart';

class ExercisePage extends GetView<ExerciseController> {
  static const String routeName = '/exercise';

  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.bodyPart.departmentName ?? ''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Obx(() => ListView.separated(
              itemBuilder: (context, index) {
                ExerciseModel model = controller.listExercise[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(ExerciseDetailPage.routeName, arguments: model);
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
                                // Container(
                                //   width: 100,
                                //   height: 100,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(4.0)),
                                //   child: ClipRRect(
                                //       borderRadius: BorderRadius.circular(4.0),
                                //       child: Image.network(
                                //         model.thumbnail!,
                                //         fit: BoxFit.cover,
                                //         errorBuilder:
                                //             (context, error, stackTrace) {
                                //           return Image.asset(
                                //               AppImage.errorLoadingImage);
                                //         },
                                //       )),
                                // ),
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
        ));
  }
}
