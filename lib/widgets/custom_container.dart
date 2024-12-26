import 'package:flutter/material.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;

  const CustomContainer(
      {super.key,
      required this.child,
      this.onTap,
      this.padding,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: borderColor ?? AppColors.borderContainer, width: 1)),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
