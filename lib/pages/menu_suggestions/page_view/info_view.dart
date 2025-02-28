import 'package:fitness_tracker/pages/menu_suggestions/menu_suggestions_controller.dart';
import 'package:fitness_tracker/widgets/input_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/const/app_colors.dart';
import '../../../widgets/button_widget.dart';

class InfoView extends GetView<MenuSuggestionsController> {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TextWidget(text: 'Tuổi của bạn: '),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: InputWidget(
                  controller: controller.ageController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          const Divider(),
          const SizedBox(height: 10,),
          const TextWidget(
            text: 'Phần lớn thời gian bạn dùng để: ',
            fontWeight: FontWeight.bold,
          ),
          Obx(() => RadioListTile(
                value: 'Làm việc văn phòng',
                onChanged: (value) {
                  controller.work.value = value!;
                },
                title: const TextWidget(text: 'Làm việc văn phòng'),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: controller.work.value,
              )),
          Obx(() => RadioListTile(
                value: 'Làm việc nặng',
                onChanged: (value) {
                  controller.work.value = value!;
                },
                title: const TextWidget(text: 'Làm việc nặng'),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: controller.work.value,
              )),
          Obx(() => RadioListTile(
                value: 'Chơi thể thao',
                onChanged: (value) {
                  controller.work.value = value!;
                },
                title: const TextWidget(text: 'Chơi thể thao'),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: controller.work.value,
              )),
          Obx(() => RadioListTile(
                value: 'Khác',
                onChanged: (value) {
                  controller.work.value = value!;
                },
                title: const TextWidget(text: 'Khác'),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: controller.work.value,
              )),
          Obx(
            () => controller.work.value == 'Khác'
                ? InputWidget(
                    controller: controller.workController,
                    labelText: 'Công việc',
                  )
                : Container(),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => (controller.student.value == null ||
                      controller.student.value!.studentBodyIndices == null)
                  ? ButtonWidget(
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
                    )
                  : Container()),
              ButtonWidget(
                text: 'Gợi ý thực đơn',
                icon: const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                ),
                height: 55,
                width: 200,
                iconAlign: ButtonIconAlign.right,
                onPressed: () async {
                  await controller.suggesMenu();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
