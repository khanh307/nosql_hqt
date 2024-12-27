import 'package:fitness_tracker/models/chart_data.dart';
import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/pages/body_indices/body_indices_controller.dart';
import 'package:fitness_tracker/pages/body_indices/new_indices/new_indices_page.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/const/app_colors.dart';

class BodyIndicesPage extends GetView<BodyIndicesController> {
  static const String routeName = '/bodyIndices';

  const BodyIndicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget itemInfo({required String title, required String content}) => Row(
          children: [
            Expanded(flex: 2, child: TextWidget(text: title)),
            Expanded(flex: 3, child: TextWidget(text: content))
          ],
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉ số cơ thể'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: 'Thông tin',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              itemInfo(
                  title: 'Họ tên',
                  content: controller.student.usersStudent!.name ?? ''),
              itemInfo(
                  title: 'Số điện thoại',
                  content: controller.student.usersStudent!.phone ?? ''),
              itemInfo(
                  title: 'Ngày sinh',
                  content: DateUtil.formatDateNotHH(
                      controller.student.usersStudent!.birthday!)),
              Divider(),
              const TextWidget(
                text: 'Chỉ số',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => chartWidget(
                  title: 'Weight (kg)',
                  chartData: controller.weightData.value)),
              const SizedBox(
                height: 5,
              ),
              Obx(() => chartWidget(
                  title: 'Body Fat (%)',
                  chartData: controller.bodyFatData.value)),
              const SizedBox(
                height: 5,
              ),
              Obx(() => chartWidget(
                  title: 'Muscle Mass (kg)',
                  chartData: controller.muscleData.value)),
              const SizedBox(
                height: 5,
              ),
              Obx(() => chartWidget(
                  title: 'BMI (kg/m²)', chartData: controller.bmiData.value))
            ],
          ),
        ),
      ),
      floatingActionButton: (controller.user is StudentModel)
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Get.toNamed(NewIndicesPage.routeName,
                    arguments: controller.student);
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Widget chartWidget(
          {required String title, required List<ChartData> chartData}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: title,
          ),
          (chartData.isNotEmpty) ? SizedBox(
            height: 150,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 1),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelStyle: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w400),
                ),
                primaryYAxis: CategoryAxis(
                    isVisible: false,
                    minimum: chartData
                        .map((data) => data.value)
                        .reduce((a, b) => a < b ? a : b)),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: '',
                ),
                series: <CartesianSeries>[
                  // Renders line chart
                  LineSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.year,
                    yValueMapper: (ChartData data, _) => data.value,
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        )),
                    color: AppColors.primaryColor,
                    markerSettings: const MarkerSettings(
                        isVisible: true, width: 8, height: 8, borderWidth: 4),
                  )
                ]),
          ) : const TextWidget(text: 'Không có dữ liệu')
        ],
      );
}
