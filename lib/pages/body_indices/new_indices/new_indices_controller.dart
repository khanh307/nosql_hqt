import 'package:fitness_tracker/models/body_indices_model.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/pages/body_indices/body_indices_controller.dart';
import 'package:fitness_tracker/services/body_indices_service.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:fitness_tracker/utils/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/dialog_util.dart';

class NewIndicesController extends GetxController {
  StudentModel student = Get.arguments;
  DateTime now = DateTime.now();
  DateTime dateSelected = DateTime.now();
  final GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyFatController = TextEditingController();
  TextEditingController muscleController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  final BodyIndicesService _bodyIndicesService = BodyIndicesService();
  final UserService _userService = UserService();

  @override
  void onInit() {
    super.onInit();
    dateSelected = DateTime(now.year, now.month, now.day);
    print('dateSelected ${dateSelected}');
    if (student.studentBodyIndices != null &&
        student.studentBodyIndices!.isNotEmpty) {
      heightController.text =
          student.studentBodyIndices!.last.height?.toString() ?? '';
    }
    heightController.addListener(
      () {
        updateBMI();
      },
    );
    weightController.addListener(
      () {
        updateBMI();
      },
    );
  }

  void updateBMI() {
    if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
      num weight = double.tryParse(weightController.text) ?? 0;
      num height = double.tryParse(heightController.text) ?? 0;
      bmiController.text =
          (weight / ((height / 100) * (height / 100))).toStringAsFixed(1);
    }
  }

  Future newBodyIndices() async {
    await DialogUtil.showLoading();
    if (!globalKey.currentState!.validate()) {
      DialogUtil.hideLoading();
      return;
    }

    dateSelected =
        DateTime(dateSelected.year, dateSelected.month, dateSelected.day);

    BodyIndicesModel indices = BodyIndicesModel(
        date: dateSelected,
        bmi: double.tryParse(bmiController.text) ?? 0,
        bodyFat: double.tryParse(bodyFatController.text) ?? 0,
        height: double.tryParse(heightController.text) ?? 0,
        muscle: double.tryParse(muscleController.text) ?? 0,
        weight: double.tryParse(weightController.text) ?? 0);

    if (student.studentBodyIndices != null &&
        student.studentBodyIndices!.isNotEmpty &&
        student.studentBodyIndices!.contains(indices)) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: 'Ngày do đã có dữ liệu');
      return;
    }
    try {
      await _bodyIndicesService.createIndices(indices: indices).then(
        (value) async {
          if (value == null) {
            throw BadRequestException('Lỗi tạo mới dữ liệu');
          }
          student.studentBodyIndices ??= [];
          student.studentBodyIndices!.add(indices);
          await _userService.updateStudent(studentModel: student).then(
            (value) {
              DialogUtil.hideLoading();
              DialogUtil.showDialogSuccess(
                text: 'Thêm mới thành công',
                actionClose: () {
                  BodyIndicesController.instants.updateChart();
                  Get.back();
                },
              );
            },
          );
        },
      );
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }


}
