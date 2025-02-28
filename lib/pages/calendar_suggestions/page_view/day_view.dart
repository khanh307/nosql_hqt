import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_controller.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const/app_colors.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/time_picker_widget.dart';

class DayView extends GetView<CalendarSuggestionController> {
  const DayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(text: 'Ngày bạn có thể tập luyên?'),
            const SizedBox(
              height: 20,
            ),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Thứ 2'],
                  onChanged: (value) {
                    controller.mapThu['Thứ 2'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Thứ 2'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Thứ 3'],
                  onChanged: (value) {
                    controller.mapThu['Thứ 3'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Thứ 3'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Thứ 4'],
                  onChanged: (value) {
                    controller.mapThu['Thứ 4'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Thứ 4'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Thứ 5'],
                  onChanged: (value) {
                    controller.mapThu['Thứ 5'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Thứ 5'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Thứ 6'],
                  onChanged: (value) {
                    controller.mapThu['Thứ 6'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Thứ 6'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Thứ 7'],
                  onChanged: (value) {
                    controller.mapThu['Thứ 7'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Thứ 7'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() =>
                CheckboxListTile(
                  value: controller.mapThu['Chủ nhật'],
                  onChanged: (value) {
                    controller.mapThu['Chủ nhật'] = value ?? false;
                  },
                  title: const TextWidget(text: 'CN'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            const Divider(),
            const TextWidget(text: 'Thời gian tập'),
            const SizedBox(height: 10,),
            Obx(() => TimePickerWidget(
              value: controller.fromTime.value,
              onChanged: (value) {
                controller.fromTime.value = value;
              },
            )),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWidget(
              height: 55,
              width: 55,
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              text: '',
              onPressed: () {
                controller.pageController.previousPage(duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },),
            ButtonWidget(
              text: 'Tiếp tục',
              icon: const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
              height: 55,
              iconAlign: ButtonIconAlign.right,
              onPressed: () {
                controller.pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
            ),
          ],
        ),
      ],
    );
  }
}
