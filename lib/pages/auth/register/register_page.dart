import 'package:fitness_tracker/core/enum/member_level_enum.dart';
import 'package:fitness_tracker/core/enum/user_type_enum.dart';
import 'package:fitness_tracker/pages/auth/register/register_controller.dart';
import 'package:fitness_tracker/pages/auth/register/register_web_page.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/text_field_format/currency_text_format.dart';
import 'package:fitness_tracker/utils/text_field_format/name_format.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/date_picker_widget.dart';
import 'package:fitness_tracker/widgets/dropdown_widget.dart';
import 'package:fitness_tracker/widgets/input_widget.dart';
import 'package:fitness_tracker/widgets/responsive_frame.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/text_field_format/validation_edittext.dart';

class RegisterPage extends GetView<RegisterController> {
  static const String routeName = '/register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đăng ký'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  InputWidget(
                    hintText: 'Tài khoản (Số điện thoại)',
                    controller: controller.usernameController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return ValidationEditText.validationRequired(value);
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
                      return ValidationEditText.validationRequired(value);
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
                      return ValidationEditText.validationRequired(value);
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
                    height: 15.0,
                  ),
                  Obx(() => InputWidget(
                        hintText: 'Nhập lại mật khẩu',
                        obscureText: controller.obscureRePassword.value,
                        controller: controller.rePasswordController,
                        validator: (value) {
                          return ValidationEditText.validationRequired(value);
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
                          DropDownItem(
                              UserTypeEnum.trainer, UserTypeEnum.trainer.value),
                          DropDownItem(
                              UserTypeEnum.student, UserTypeEnum.student.value)
                        ],
                        onChange: (value) {
                          controller.userTypeSelected.value = value;
                        },
                      )),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Obx(
                    () => (controller.userTypeSelected.value ==
                            UserTypeEnum.student)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                child: const TextWidget(
                                  text: 'Hạng thẻ',
                                  size: 14,
                                  color: Color.fromRGBO(124, 124, 124, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Obx(() => RadioListTile(
                                    value: MemberLevelEnum.bronze,
                                    onChanged: (value) {
                                      controller.memberLevel.value = value!;
                                    },
                                    title: const Text(MemberLevelEnum.bronze),
                                    activeColor: AppColors.primaryColor,
                                    groupValue: controller.memberLevel.value,
                                  )),
                              Obx(() => RadioListTile(
                                  value: MemberLevelEnum.silver,
                                  onChanged: (value) {
                                    controller.memberLevel.value = value!;
                                  },
                                  title: const Text('Bạc'),
                                  activeColor: AppColors.primaryColor,
                                  groupValue: controller.memberLevel.value)),
                              Obx(() => RadioListTile(
                                    value: MemberLevelEnum.gold,
                                    onChanged: (value) {
                                      controller.memberLevel.value = value!;
                                    },
                                    title: const Text('Vàng'),
                                    activeColor: AppColors.primaryColor,
                                    groupValue: controller.memberLevel.value,
                                  )),
                            ],
                          )
                        : Container(),
                  ),
                  Obx(() => (controller.userTypeSelected.value ==
                          UserTypeEnum.trainer)
                      ? InputWidget(
                          hintText: 'Mức lương',
                          controller: controller.salaryController,
                          inputFormater: [CurrencyTextFormat()],
                          keyboardType: TextInputType.number,
                          validator: (value) {},
                        )
                      : Container()),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => (controller.userTypeSelected.value ==
                            UserTypeEnum.trainer)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 12),
                                child: const TextWidget(
                                  text: 'Level',
                                  size: 14,
                                  color: Color.fromRGBO(124, 124, 124, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Obx(() => CheckboxListTile(
                                    value: controller.level1.value,
                                    onChanged: (value) {
                                      controller.level1.value = value!;
                                    },
                                    title: const Text('Cấp 1'),
                                    activeColor: AppColors.primaryColor,
                                  )),
                              Obx(() => CheckboxListTile(
                                    value: controller.level2.value,
                                    onChanged: (value) {
                                      controller.level2.value = value!;
                                    },
                                    title: const Text('Cấp 2'),
                                    activeColor: AppColors.primaryColor,
                                  )),
                              Obx(() => CheckboxListTile(
                                    value: controller.level3.value,
                                    onChanged: (value) {
                                      controller.level3.value = value!;
                                    },
                                    title: const Text('Cấp 3'),
                                    activeColor: AppColors.primaryColor,
                                  )),
                            ],
                          )
                        : Container(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonWidget(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
