import 'package:fitness_tracker/pages/auth/register/register_controller.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/text_field_format/name_format.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/date_picker_widget.dart';
import 'package:fitness_tracker/widgets/dropdown_widget.dart';
import 'package:fitness_tracker/widgets/input_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/enum/user_type_enum.dart';
import '../../../utils/text_field_format/validation_edittext.dart';

class RegisterWebPage extends GetView<RegisterController> {
  const RegisterWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Card(
                child: SizedBox(
                  width: 700,
                  height: 800,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: controller.globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: TextWidget(
                              text: 'ĐĂNG KÝ',
                              fontWeight: FontWeight.bold,
                              size: 30,
                              color: AppColors.primaryColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InputWidget(
                            hintText: 'Tài khoản (Số điện thoại)',
                            controller: controller.usernameController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              return ValidationEditText.validationRequired(
                                  value);
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InputWidget(
                            hintText: 'Họ tên',
                            controller: controller.fullnameController,
                            keyboardType: TextInputType.phone,
                            inputFormater: [NameFormat()],
                            validator: (value) {
                              return ValidationEditText.validationRequired(
                                  value);
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          InputWidget(
                            hintText: 'Email',
                            controller: controller.emailController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return ValidationEditText.validationRequired(
                                  value);
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Obx(() => InputWidget(
                                hintText: 'Mật khẩu',
                                obscureText: controller.obscurePassword.value,
                                controller: controller.passwordController,
                                validator: (value) {
                                  return ValidationEditText.validationRequired(
                                      value);
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
                            height: 15.0,
                          ),
                          Obx(() => InputWidget(
                                hintText: 'Nhập lại mật khẩu',
                                obscureText: controller.obscureRePassword.value,
                                controller: controller.rePasswordController,
                                validator: (value) {
                                  return ValidationEditText.validationRequired(
                                      value);
                                },
                                suffixIcon: (controller.obscureRePassword.value)
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                onTapSuffix: () {
                                  controller.obscureRePassword.value =
                                      !controller.obscureRePassword.value;
                                },
                              )),
                          const SizedBox(
                            height: 15.0,
                          ),
                          DatePickerWidget(
                            labelText: 'Ngày sinh',
                            onChanged: (value) {
                              controller.dateSelected = value;
                            },
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: const TextWidget(
                              text: 'Giới tính',
                              size: 14,
                              color: Color.fromRGBO(124, 124, 124, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                      activeColor: AppColors.primaryColor,
                                      value: true,
                                      groupValue: controller.sexValue.value,
                                      onChanged: (value) {
                                        controller.sexValue.value = value!;
                                      },
                                      title: const Text('Nam'),
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      value: false,
                                      activeColor: AppColors.primaryColor,
                                      groupValue: controller.sexValue.value,
                                      onChanged: (value) {
                                        controller.sexValue.value = value!;
                                      },
                                      title: const Text('Nữ'),
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Obx(() => DropdownWidget(
                                value: controller.userTypeSelected.value,
                                items: [
                                  DropDownItem(UserTypeEnum.trainer,
                                      UserTypeEnum.trainer.value),
                                  DropDownItem(UserTypeEnum.student,
                                      UserTypeEnum.student.value)
                                ],
                                onChange: (value) {
                                  controller.userTypeSelected.value = value;
                                },
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ButtonWidget(
                                  backgroundColor: Colors.orange,
                                  text: 'Đăng nhập',
                                  icon: const Icon(
                                    Icons.keyboard_backspace,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    Get.back();
                                  },
                                  isResponsive: true,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 4,
                                child: ButtonWidget(
                                  text: 'Đăng Ký',
                                  onPressed: () async {
                                    if (controller.userTypeSelected.value ==
                                        UserTypeEnum.trainer) {
                                      await controller.registerTrainer();
                                    } else {
                                      await controller.registerStudent();
                                    }
                                  },
                                  isResponsive: true,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
