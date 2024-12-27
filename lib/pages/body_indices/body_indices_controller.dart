import 'package:fitness_tracker/core/singleton.dart';
import 'package:fitness_tracker/models/body_indices_model.dart';
import 'package:fitness_tracker/models/chart_data.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/const/app_colors.dart';

class BodyIndicesController extends GetxController {
  static BodyIndicesController get instants => Get.find();
  StudentModel student = Get.arguments ?? Singleton().user!;
  UserModel user = Singleton().user!;
  final UserService _userService = UserService();
  RxList<ChartData> weightData = <ChartData>[].obs;
  RxList<ChartData> bodyFatData = <ChartData>[].obs;
  RxList<ChartData> muscleData = <ChartData>[].obs;
  RxList<ChartData> bmiData = <ChartData>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await _getStudentIndices();
  }

  Future _getStudentIndices() async {
    await DialogUtil.showLoading();
    await _userService.getStudentById(student.id!).then(
      (value) {
        if (value != null) {
          student = value;
          updateChart();
          DialogUtil.hideLoading();
        }
      },
    );
  }

  void updateChart() {
    weightData.clear();
    bodyFatData.clear();
    muscleData.clear();
    bmiData.clear();
    if (student.studentBodyIndices != null && student.studentBodyIndices!.isNotEmpty) {
      student.studentBodyIndices!.sort((a, b) => a.date!.compareTo(b.date!));
      for (BodyIndicesModel indices in student.studentBodyIndices!) {
        weightData.add(ChartData(year: DateUtil.formatDate7(indices.date!), value: indices.weight?.toDouble() ?? 0));
        bodyFatData.add(ChartData(year: DateUtil.formatDate7(indices.date!), value: indices.bodyFat?.toDouble() ?? 0));
        muscleData.add(ChartData(year: DateUtil.formatDate7(indices.date!), value: indices.muscle?.toDouble() ?? 0));
        bmiData.add(ChartData(year: DateUtil.formatDate7(indices.date!), value: indices.bmi?.toDouble() ?? 0));
      }
    }
  }
}
