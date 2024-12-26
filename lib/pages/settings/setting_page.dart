import 'package:fitness_tracker/pages/settings/setting_controller.dart';
import 'package:fitness_tracker/widgets/custom_container.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  static const String routeName = '/setting';

  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomContainer(
              child: Row(
                children: [
                  Image.asset('assets/images/account.png', width: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextWidget(text: 'Thông tin cá nhân')
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            CustomContainer(
              child: Row(
                children: [
                  Image.asset('assets/images/logout.png', width: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextWidget(text: 'Đăng xuất')
                ],
              ),
              onTap: () async {
                await controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
