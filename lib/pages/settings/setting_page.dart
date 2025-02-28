import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_page.dart';
import 'package:fitness_tracker/pages/menu_suggestions/menu_suggestions_page.dart';
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
                  const TextWidget(text: 'Gợi ý lịch tập')
                ],
              ),
              onTap: () {
                  Get.toNamed(CalendarSuggestionPage.routeName);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomContainer(
              child: Row(
                children: [
                  Image.asset('assets/images/foods.png', width: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextWidget(text: 'Gợi ý thực đơn')
                ],
              ),
              onTap: () {
                Get.toNamed(MenuSuggestionsPage.routeName);
              },
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
