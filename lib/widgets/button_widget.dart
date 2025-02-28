import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double width;
  final Color textColor;
  final double height;
  final Color backgroundColor;
  final bool isResponsive;
  final Widget? icon;
  final ButtonIconAlign iconAlign;

  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width = 150.0,
      this.height = 59.0,
      this.textColor = Colors.white,
      this.backgroundColor = AppColors.primaryColor,
      this.isResponsive = false,
      this.icon,
      this.iconAlign = ButtonIconAlign.left});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      child: Container(
        height: height,
        width: (isResponsive) ? Get.width : width,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(4.0)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (icon != null && iconAlign == ButtonIconAlign.left)
                  ? icon!
                  : Container(),
              (icon != null && iconAlign == ButtonIconAlign.left)
                  ? const SizedBox(width: 6.0)
                  : Container(),
              TextWidget(
                text: text,
                color: Colors.white,
                size: 18.0,
                fontWeight: FontWeight.bold,
              ),
              (icon != null && iconAlign == ButtonIconAlign.right)
                  ? const SizedBox(width: 6.0)
                  : Container(),
              (icon != null && iconAlign == ButtonIconAlign.right)
                  ? icon!
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonIconAlign { left, right }
