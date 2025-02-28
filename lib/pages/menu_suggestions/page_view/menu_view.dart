
import 'package:fitness_tracker/pages/menu_suggestions/menu_suggestions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MenuView extends GetView<MenuSuggestionsController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HtmlWidget(
          controller.resultAI.value
        ),
      ),
    );
  }
}
