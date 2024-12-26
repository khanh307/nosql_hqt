import 'package:fitness_tracker/core/singleton.dart';
import 'package:fitness_tracker/pages/auth/login/login_page.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:fitness_tracker/utils/shared_pref.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  Future logout() async {
    DialogUtil.showDialog(
        title: 'Đăng xuất',
        content: const TextWidget(text: 'Bạn chắn chắn muốn đăng xuất?'),
        actions: [
          ActionDialog(
            text: 'HỦY',
            onPressed: () {
              Get.back();
            },
          ),
          ActionDialog(
            text: 'OK',
            onPressed: () async {
              Get.back();
              DialogUtil.showLoading();
              Singleton().logout();
              DialogUtil.hideLoading();
              Get.offAllNamed(LoginPage.routeName);
            },
          )
        ]);
  }
}
