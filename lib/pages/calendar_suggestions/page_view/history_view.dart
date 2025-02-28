import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_controller.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const/app_colors.dart';
import '../../../widgets/text_widget.dart';

class HistoryView extends GetView<CalendarSuggestionController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
                text:
                    'Bạn có muốn sử dụng lịch sử tập luyện của mình trên ứng dụng?'),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => RadioListTile(
                value: 'Có',
                onChanged: (value) {
                  controller.useHistory.value = value!;
                },
                title: const TextWidget(text: 'Có'),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: controller.useHistory.value,
              ),
            ),
            Obx(
              () => RadioListTile(
                value: 'Không',
                onChanged: (value) {
                  controller.useHistory.value = value!;
                },
                title: const TextWidget(text: 'Không'),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: controller.useHistory.value,
              ),
            ),
            const Divider(),
            const TextWidget(text: 'Mục tiêu tập luyện của bạn?'),
            Obx(() => CheckboxListTile(
                  value: controller.goal['Tăng cơ'],
                  onChanged: (value) {
                    controller.goal['Tăng cơ'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Tăng cơ'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                )),
            Obx(() => CheckboxListTile(
                  value: controller.goal['Giảm mỡ'],
                  onChanged: (value) {
                    controller.goal['Giảm mỡ'] = value ?? false;
                  },
                  title: const TextWidget(text: 'Giảm mỡ'),
                  activeColor: AppColors.primaryColor,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
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
                controller.pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
            ),
            ButtonWidget(
              text: 'Gợi ý lịch tập',
              icon: const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,
              ),
              height: 55,
              width: 200,
              iconAlign: ButtonIconAlign.right,
              onPressed: () async {
                await controller.suggess();
              },
            ),
          ],
        ),
      ],
    );
  }
}
