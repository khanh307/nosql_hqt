import 'package:fitness_tracker/pages/exercise/exercise_detail/exercise_detail_page.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/exercise_model.dart';
import '../../../utils/const/app_colors.dart';
import '../../../utils/const/app_images.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/text_widget.dart';
import 'calendar_detail_controller.dart';

class CalendarDetailPage extends GetView<CalendarDetailController> {
  static const String routeName = '/calendarDetail';

  const CalendarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thêm lịch'),
          actions: [
            IconButton(onPressed: () {
              controller.showDialogConfirmDelete();
            }, icon: const Icon(Icons.delete, color: Colors.white,))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'HLV: ${controller.calendar.calendarTraner!.first.name}',
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextWidget(
                  text: 'Học viên',
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                (controller.calendar.calenderStudent != null)
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount:
                              controller.calendar.calenderStudent!.length,
                          itemBuilder: (context, index) => CustomContainer(
                            onTap: () {},
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image.asset(controller.calendar
                                                .calenderStudent![index].sex!
                                            ? AppImage.userMaleImage
                                            : AppImage.userFemaleImage),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: controller
                                                    .calendar
                                                    .calenderStudent![index]
                                                    .name ??
                                                '',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextWidget(
                                              text: controller
                                                      .calendar
                                                      .calenderStudent![index]
                                                      .phone ??
                                                  '')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                const TextWidget(
                  text: 'Thời gian',
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text: 'Bắt đầu',
                      ),
                    ),
                    TextWidget(
                      text: DateUtil.formatDate(controller.calendar.startTime!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text: 'Kết thúc',
                      ),
                    ),
                    TextWidget(
                      text: DateUtil.formatDate(controller.calendar.endTime!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextWidget(
                  text: 'Bài tập',
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ExerciseModel model =
                          controller.calendar.calendarExercise![index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(ExerciseDetailPage.routeName, arguments: model);
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: AppColors.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.calendar.calendarExercise!.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
