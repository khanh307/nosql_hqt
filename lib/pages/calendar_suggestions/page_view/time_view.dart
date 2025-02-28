import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_controller.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const/app_colors.dart';
import '../../../widgets/text_widget.dart';

class TimeView extends GetView<CalendarSuggestionController> {
  const TimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
                text: 'Bạn dành thời gian bao lâu cho một buổi tập?'),
            const SizedBox(
              height: 20,
            ),
            Obx(() => RadioListTile(
                  value: '30 đến 40',
                  onChanged: (value) {
                    controller.valueTime.value = value!;
                  },
                  title: const TextWidget(text: '30 đến 40 phút'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  groupValue: controller.valueTime.value,
                )),
            Obx(() => RadioListTile(
                  value: '40 đến 60',
                  onChanged: (value) {
                    controller.valueTime.value = value!;
                  },
                  title: const TextWidget(text: '40 đến 60 phút'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  groupValue: controller.valueTime.value,
                )),
            Obx(() => RadioListTile(
                  value: '60 đến 80',
                  onChanged: (value) {
                    controller.valueTime.value = value!;
                  },
                  title: const TextWidget(text: '60 đến 80 phút'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  groupValue: controller.valueTime.value,
                )),
            Obx(() => RadioListTile(
                  value: 'Hơn 1.5 giờ',
                  onChanged: (value) {
                    controller.valueTime.value = value!;
                  },
                  title: const TextWidget(text: 'Hơn 1.5 giờ'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  groupValue: controller.valueTime.value,
                ))
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
                controller.pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
            ),
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
