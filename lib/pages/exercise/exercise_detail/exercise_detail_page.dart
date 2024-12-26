import 'package:chewie/chewie.dart';
import 'package:fitness_tracker/models/exercise_model.dart';
import 'package:fitness_tracker/pages/exercise/exercise_detail/exercise_detail_controller.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/loading_widget.dart';
import 'package:fitness_tracker/widgets/responsive_frame.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class ExerciseDetailPage extends GetView<ExerciseDetailController> {
  static const String routeName = '/exerciseDetail';

  const ExerciseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.model.exerciseName ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: controller.model.exerciseName ?? '',
                size: 20,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => (controller.chewieController.value != null)
                  ? AspectRatio(
                aspectRatio: controller.videoController.value.aspectRatio,
                child: Chewie(
                    controller: controller.chewieController.value!),
              )
                  : const Center(child: LoadingWidget())),
              const SizedBox(
                height: 10,
              ),
              Obx(() => (controller.chewieController2.value != null)
                  ? AspectRatio(
                aspectRatio:
                controller.videoController2.value.aspectRatio,
                child: Chewie(
                    controller: controller.chewieController2.value!),
              )
                  : const Center(child: LoadingWidget())),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(1000)),
                        child: Center(
                          child: TextWidget(
                            text: '${index + 1}',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 20,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextWidget(
                            text: controller.model.descriptions![index],
                            maxLines: 10,
                            textAlign: TextAlign.justify,
                          ))
                    ],
                  );
                },
                itemCount: controller.model.descriptions!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Obx(() => (controller.isSelected.value)
      //     ? Container(
      //         padding: const EdgeInsets.all(10),
      //         child: (!NewCalendarController.instants.listExercise
      //                 .contains(controller.model))
      //             ? ButtonWidget(
      //                 onPressed: () {
      //                   controller.pickExercise();
      //                 },
      //                 text: 'Thêm',
      //                 isResponsive: true,
      //                 height: 45,
      //               )
      //             : ButtonWidget(
      //                 onPressed: () {
      //                   controller.removeExercise();
      //                 },
      //                 text: 'Xóa',
      //                 backgroundColor: AppColors.red,
      //                 isResponsive: true,
      //                 height: 45,
      //               ),
      //       ): Container(width: 0, height: 0,)) ,
    );
  }
}
