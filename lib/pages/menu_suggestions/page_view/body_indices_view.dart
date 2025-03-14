
import 'package:fitness_tracker/pages/menu_suggestions/menu_suggestions_controller.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/text_field_format/validation_edittext.dart';
import '../../../widgets/input_widget.dart';

class BodyIndicesView extends GetView<MenuSuggestionsController> {
  const BodyIndicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const TextWidget(text: 'Không tìm thấy chỉ số body của bạn. Bạn vui lòng nhập các chỉ số sau để chúng tôi gợi ý'),
          const SizedBox(height: 20,),
          InputWidget(
            labelText: 'Weight (kg)',
            controller: controller.weightController,
            keyboardType: TextInputType.number,
            validator: (value) {
              return ValidationEditText.validationRequired(value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          InputWidget(
            labelText: 'Height (cm)',
            controller: controller.heightController,
            keyboardType: TextInputType.number,
            validator: (value) {
              return ValidationEditText.validationRequired(value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          InputWidget(
            labelText: 'Body fat (%)',
            controller: controller.bodyFatController,
            keyboardType: TextInputType.number,
            validator: (value) {
              return ValidationEditText.validationRequired(value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          InputWidget(
            labelText: 'Muscle Mass (kg)',
            controller: controller.muscleController,
            keyboardType: TextInputType.number,
            validator: (value) {
              return ValidationEditText.validationRequired(value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          InputWidget(
            labelText: 'BMI (kg/m²)',
            controller: controller.bmiController,
            keyboardType: TextInputType.number,
            validator: (value) {
              return ValidationEditText.validationRequired(value);
            },
          ),
          const SizedBox(height: 30,),
          ButtonWidget(
            text: 'Tiếp tục',
            icon: const Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
            height: 55,
            iconAlign: ButtonIconAlign.right,
            onPressed: () {
              controller.pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            },
          ),
        ],
      ),
    );
  }
}
