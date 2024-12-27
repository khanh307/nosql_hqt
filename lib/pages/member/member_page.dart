import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/pages/body_indices/body_indices_page.dart';
import 'package:fitness_tracker/pages/member/member_controller.dart';

import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/const/app_images.dart';
import 'package:fitness_tracker/widgets/custom_container.dart';
import 'package:fitness_tracker/widgets/responsive_frame.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberPage extends GetView<MemberController> {
  static const String routeName = '/member';

  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hội viên'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Obx(() => ListView.separated(
            itemBuilder: (context, index) {
              UserModel model = controller.listMember[index].usersStudent!;
              return CustomContainer(
                onTap: () {
                  Get.toNamed(BodyIndicesPage.routeName, arguments: controller.listMember[index]);
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset(model.sex ?? false
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
            itemCount: controller.listMember.length)),
      ),
    );
  }
}
