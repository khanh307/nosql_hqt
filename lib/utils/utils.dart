import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

Color getColor(String? input) {
  input = (input ?? '#0d6efd').replaceAll("#", "");
  return Color(int.parse('FF$input', radix: 16));
}

class Utils {
  static Future<bool> checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  static String generateUUID() {
    const uuidGenerator = Uuid();
    return uuidGenerator.v4();
  }
}

extension NatigatorPage on GetxController {
  void goToPage({required String routeName, dynamic arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  void loadMoreData(
      {required ScrollController scrollController,
      required Function() function}) async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await function();
      }
    });
  }
}
