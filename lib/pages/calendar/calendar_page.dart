import 'package:calendar_view/calendar_view.dart';
import 'package:fitness_tracker/bindings/all_bindings.dart';
import 'package:fitness_tracker/models/calendar_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/pages/calendar/calendar_controller.dart';
import 'package:fitness_tracker/pages/calendar/new_calendar/new_calendar_page.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:fitness_tracker/widgets/timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../../widgets/responsive_frame.dart';
import '../bottom_nav/bottom_nav_controller.dart';
import 'calendar_detail/calendar_detail_page.dart';

class CalendarPage extends GetView<CalendarController> {
  static const String routeName = '/home';

  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    AllBindings().dependencies();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => TextWidget(
                text:
                    '${DateUtil.formatThu(controller.dateSelected.value, false)} '
                    '${DateUtil.formatDateNotHH(controller.dateSelected.value)}')),
            Obx(() => WeeklyDatePicker(
                  selectedDay: controller.dateSelected.value,
                  // DateTime
                  changeDay: (value) async {
                    controller.dateSelected.value = value;
                    await controller.getCalendar();
                  },
                  backgroundColor: Colors.white,
                  enableWeeknumberText: false,
                  selectedDigitColor: Colors.white,
                  selectedDigitBackgroundColor: AppColors.primaryColor,
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => (controller.listCalendar.isNotEmpty)
                ? TimelineWidget(
                    items: controller.listCalendar
                        .map((e) => ItemTimeline(
                            title:
                                'Thành viên: ${e.calenderStudent?.length ?? 0}',
                            startTime: e.startTime!,
                            endTime: e.endTime!,
                            description: ''))
                        .toList(),
                    onItemPressed: (int index) {
                      Get.toNamed(CalendarDetailPage.routeName,
                          arguments: controller.listCalendar[index]);
                    },
                  )
                : const Center(
                    child: TextWidget(text: 'Không có lịch'),
                  ))
          ],
        ),
      ),
      floatingActionButton: (controller.user is TrainerModel) ? FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.toNamed(NewCalendarPage.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ) : null,
    );
  }
}
