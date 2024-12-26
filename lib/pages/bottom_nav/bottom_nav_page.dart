import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fitness_tracker/bindings/all_bindings.dart';
import 'package:fitness_tracker/pages/bottom_nav/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavPage extends GetView<BottomNavController> {
  static const String routeName = '/bottomNav';

  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              AllBindings().dependencies();
              controller.selectedIndex.value = index;
            },
            children: controller.pages,
          ),
        ),
        bottomNavigationBar: Obx(() => BottomNavyBar(
          backgroundColor: Colors.white,
          itemCornerRadius: 80,
          containerHeight: 58,
          selectedIndex: controller.selectedIndex.value,
          showElevation: true,
          showInactiveTitle: false,
          onItemSelected: (index) {
            controller.selectedIndex.value = index;
            controller.pageController.jumpToPage(index);
          },
          items: controller.items.value,
        )));
  }
}