import 'package:fitness_tracker/pages/bottom_nav/bottom_nav_controller.dart';
import 'package:fitness_tracker/pages/calendar/new_calendar/new_calendar_controller.dart';
import 'package:fitness_tracker/pages/member/member_page.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/date_picker_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:fitness_tracker/widgets/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/exercise_model.dart';
import '../../../utils/const/app_colors.dart';
import '../../../utils/const/app_images.dart';
import '../../../widgets/custom_container.dart';

class NewCalendarPage extends GetView<NewCalendarController> {
  static const String routeName = '/newCalendar';

  const NewCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thêm lịch'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.goToMemberPicker();
                  },
                  child: Container(
                    width: Get.width,
                    height: 59,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border:
                            Border.all(color: AppColors.textColor, width: 1)),
                    child: const TextWidget(
                      text: 'Thêm học viên',
                    ),
                  ),
                ),
                Obx(() => (controller.studentSelected.isNotEmpty)
                    ? SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: controller.studentSelected.length,
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
                                        child: Image.asset(controller
                                                .studentSelected[index]
                                                .usersStudent!
                                                .sex!
                                            ? AppImage.userMaleImage
                                            : AppImage.userFemaleImage),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: controller.studentSelected[index]
                                                    .usersStudent!.name ??
                                                '',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextWidget(
                                              text: controller.studentSelected[index]
                                                      .usersStudent!.phone ??
                                                  '')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(onPressed: () {
                                  controller.studentSelected.remove(controller.studentSelected[index]);
                                }, icon: const Icon(Icons.remove_circle))
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container()),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Obx(() => DatePickerWidget(
                            value: controller.fromDate.value,
                            onChanged: (value) {
                              controller.fromDate.value = value;
                              controller.fromDate.value.copyWith(
                                  hour: controller.fromTime.value.hour,
                                  minute: controller.fromTime.value.minute);
                            },
                            labelText: 'Ngày bắt đầu',
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(() => TimePickerWidget(
                            value: controller.fromTime.value,
                            onChanged: (value) {
                              controller.fromTime.value = value;
                              controller.changeTime();
                            },
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Obx(() => DatePickerWidget(
                            value: controller.toDate.value,
                            onChanged: (value) {
                              controller.toDate.value = value;
                            },
                            labelText: 'Ngày kết thúc',
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(() {
                        return TimePickerWidget(
                          value: controller.toTime.value,
                          onChanged: (value) {
                            controller.toTime.value = value;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    controller.goToExercisePicker();
                  },
                  child: Container(
                    width: Get.width,
                    height: 59,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border:
                            Border.all(color: AppColors.textColor, width: 1)),
                    child: const Center(
                      child: TextWidget(
                        text: 'Chọn bài tập',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ExerciseModel model =
                          controller.listExerciseSelected[index];
                      return Card(
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
                              IconButton(
                                  onPressed: () {
                                    controller.listExerciseSelected
                                        .remove(model);
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.listExerciseSelected.length))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: Get.width,
          // height: 50,
          padding:
              const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
          child: ButtonWidget(
            text: 'Thêm lịch',
            onPressed: () async {
              await controller.newCalendar();
            },
          ),
        ),
      ),
    );
  }
}
