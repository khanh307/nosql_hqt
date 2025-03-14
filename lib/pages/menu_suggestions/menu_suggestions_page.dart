import 'package:fitness_tracker/pages/menu_suggestions/menu_suggestions_controller.dart';
import 'package:fitness_tracker/pages/menu_suggestions/page_view/body_indices_view.dart';
import 'package:fitness_tracker/pages/menu_suggestions/page_view/info_view.dart';
import 'package:fitness_tracker/pages/menu_suggestions/page_view/menu_view.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuSuggestionsPage extends GetView<MenuSuggestionsController> {
  static const String routeName = '/menuSuggestions';

  const MenuSuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gợi ý thực đơn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() => (controller.student.value == null ||
            controller.student.value!.studentBodyIndices == null || controller.student.value!.studentBodyIndices!.isEmpty) ? PageView(
          controller: controller.pageController,
          children: [
            BodyIndicesView(),
            InfoView(),
            MenuView()
          ],
        ) : PageView(
          controller: controller.pageController,
          children: [
            InfoView(),
            MenuView()
          ],
        )
        ),
      )
    );
  }
}
