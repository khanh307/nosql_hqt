import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/jsons/loading.json',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
