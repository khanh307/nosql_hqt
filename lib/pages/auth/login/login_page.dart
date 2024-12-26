import 'package:fitness_tracker/pages/auth/login/login_controller.dart';
import 'package:fitness_tracker/pages/auth/login/login_web_page.dart';
import 'package:fitness_tracker/pages/auth/register/register_page.dart';

import 'package:fitness_tracker/utils/const/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const/app_colors.dart';
import '../../../utils/text_field_format/validation_edittext.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/text_widget.dart';

class LoginPage extends GetView<LoginController> {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: Get.height / 3,
                  width: Get.width,
                  child: Image.asset(
                    AppImage.fitnessGif,
                    fit: BoxFit.cover,
                  )),
              formLogin(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  isResponsive: true,
                  text: 'Đăng Nhập',
                  onPressed: () async {
                    await controller.login();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              register()
            ],
          ),
        ),
        bottomNavigationBar: const TextWidget(
          text: 'Powered by Quoc Thao Ho',
          color: AppColors.textColor,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget formLogin() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextWidget(
                text: 'ĐĂNG NHẬP',
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                size: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Tài khoản',
                controller: controller.usernameController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  return ValidationEditText.validationRequired(value);
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Obx(() => InputWidget(
                    hintText: 'Mật khẩu',
                    obscureText: controller.obscurePassword.value,
                    controller: controller.passwordController,
                    validator: (value) {
                      return ValidationEditText.validationRequired(value);
                    },
                    suffixIcon: (controller.obscurePassword.value)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onTapSuffix: () {
                      controller.obscurePassword.value =
                          !controller.obscurePassword.value;
                    },
                  )),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      );

  Widget register() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            text: 'Bạn chưa có tài khoản?',
            color: AppColors.textColor,
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              Get.toNamed(RegisterPage.routeName);
            },
            child: const TextWidget(
              text: 'Đăng ký',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
}
