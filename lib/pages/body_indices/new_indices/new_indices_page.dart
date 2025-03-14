import 'package:fitness_tracker/pages/body_indices/new_indices/new_indices_controller.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/date_picker_widget.dart';
import 'package:fitness_tracker/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/text_field_format/validation_edittext.dart';

class NewIndicesPage extends GetView<NewIndicesController> {
  static const String routeName = '/newIndices';

  const NewIndicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thêm chỉ số'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.globalKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DatePickerWidget(
                    value: controller.dateSelected,
                    onChanged: (value) {
                      controller.dateSelected = value;
                    },
                    labelText: 'Ngày đo',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          child: ButtonWidget(
            text: 'Tiếp tục',
            onPressed: () async {
              await controller.newBodyIndices();
            },
          ),
        ),
      ),
    );
  }
}
