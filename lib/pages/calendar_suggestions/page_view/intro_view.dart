import 'package:fitness_tracker/pages/calendar_suggestions/calendar_suggestion_controller.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/widgets/button_widget.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroView extends GetView<CalendarSuggestionController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/question.png'),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: TextWidget(
            textAlign: TextAlign.justify,
            text:
                'Bạn vui lòng trả lời các câu hỏi để chúng tôi có thêm thông tin tạo lịch tập cho bạn?',
            color: AppColors.primaryColor,
            size: 17,
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        ButtonWidget(
          text: 'Tiếp tục',
          icon: Icon(
            Icons.arrow_right_alt,
            color: Colors.white,
          ),
          height: 55,
          iconAlign: ButtonIconAlign.right,
          onPressed: () {
            controller.pageController.nextPage(
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        )
      ],
    );
  }
}
