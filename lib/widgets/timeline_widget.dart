import 'dart:async';

import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/date_util.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimelineWidget extends StatefulWidget {
  final List<ItemTimeline> items;
  final Function(int index) onItemPressed;

  const TimelineWidget(
      {super.key, required this.items, required this.onItemPressed});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  DateTime _now = DateTime.now();

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startPeriodicRebuild();
  }

  void _startPeriodicRebuild() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        ItemTimeline item = widget.items[index];
        if (_now.isAfter(item.startTime) && _now.isBefore(item.endTime)) {
          return GestureDetector(
            onTap: () {
              widget.onItemPressed(index);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.cardBackgroundColor, width: 2)),
                      child: Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.cardBackgroundColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    (index < widget.items.length - 1)
                        ? Container(
                            width: 2,
                            height: 105,
                            decoration: const BoxDecoration(
                                color: AppColors.cardBackgroundColor),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(20),
                    height: 130,
                    decoration: BoxDecoration(
                        color: AppColors.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: item.title,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              size: 20,
                            ),
                            TextWidget(
                              text: DateUtil.formatTime(item.startTime),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: item.description,
                              color: Colors.white,
                            ),
                            const TextWidget(
                              text: '|',
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextWidget(
                              text: '',
                              color: Colors.white,
                            ),
                            TextWidget(
                              text: DateUtil.formatTime(item.endTime),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            widget.onItemPressed(index);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(
                    width: 22,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: AppColors.cardBackgroundColor, width: 2)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  (index < widget.items.length - 1)
                      ? Container(
                          width: 2,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: AppColors.cardBackgroundColor),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  height: 70,
                  decoration: BoxDecoration(
                      color: AppColors.cardUnenableColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: item.title,
                            fontWeight: FontWeight.bold,
                            size: 16,
                          ),
                          TextWidget(
                            text: '${DateUtil.formatTime(item.startTime)} -> ${DateUtil.formatTime(item.endTime)}',
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

   @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}

class ItemTimeline {
  String title;
  DateTime startTime;
  DateTime endTime;
  String description;

  ItemTimeline(
      {required this.title,
      required this.startTime,
      required this.endTime,
      required this.description});
}
