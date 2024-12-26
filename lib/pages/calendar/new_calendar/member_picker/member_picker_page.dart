import 'package:fitness_tracker/pages/calendar/new_calendar/new_calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/const/app_colors.dart';
import '../../../../utils/const/app_images.dart';
import '../../../../widgets/custom_container.dart';
import '../../../../widgets/text_widget.dart';

class MemberPickerPage extends GetView<NewCalendarController> {
  static const String routeName = '/memberPicker';

  const MemberPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn hội viên'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Obx(() => ListView.separated(
            itemBuilder: (context, index) {
              UserModel model = controller.listStudent[index];
              return CustomContainer(
                onTap: () {
                  controller.studentSelected.value = model;
                  Get.back();
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset(model.sex!
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
                          text: model.name ?? '',
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(text: model.phone ?? '')
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: controller.listStudent.length)),
      ),
    );
  }
}
