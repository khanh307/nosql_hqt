import 'package:fitness_tracker/models/body_part_model.dart';
import 'package:fitness_tracker/pages/body_part/body_part_controller.dart';
import 'package:fitness_tracker/pages/exercise/exercise_page.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/widgets/loading_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyPartPage extends GetView<BodyPartController> {
  static const String routeName = '/bodyPart';

  const BodyPartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài tập"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Obx(() => ListView.separated(
            itemBuilder: (context, index) {
              BodyPartModel model = controller.listBodyPart[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(ExercisePage.routeName, arguments: model);
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: AppColors.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Image.network(
                              model.departmentImages ?? '',
                              fit: BoxFit.cover,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (frame == null) {
                                  return const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: LoadingWidget(),
                                  );
                                }
                                return child;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextWidget(
                          text: model.departmentName ?? '',
                          fontWeight: FontWeight.bold,
                        )
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
            itemCount: controller.listBodyPart.length)),
      ),
    );
  }
}
