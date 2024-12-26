import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveFrame extends StatelessWidget {
  final Widget webPage;
  final Widget mobilePage;

  const ResponsiveFrame(
      {super.key, required this.webPage, required this.mobilePage});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        return webPage;
      }
      return mobilePage;
    });
  }
}
