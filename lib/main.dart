
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_tracker/routes/app_routes.dart';
import 'package:fitness_tracker/services/fcm_service.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'bindings/all_bindings.dart';
import 'firebase_options.dart';
import 'package:fitness_tracker/core/singleton.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('vi', null);
  await FCMService.setUpFCM();

  Singleton().initial();
  await dotenv.load(fileName: 'assets/app.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        cardColor: AppColors.backgroundColor,
        fontFamily: 'BeVietNamPro',
        cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            color: AppColors.backgroundCard,
            surfaceTintColor: AppColors.backgroundCard),
        dialogTheme: const DialogTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            titleTextStyle: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          elevation: 5,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            modalBackgroundColor: Colors.white),
        appBarTheme: const AppBarTheme(
            elevation: 3,
            color: AppColors.primaryColor,
            shadowColor: AppColors.textColor,
            surfaceTintColor: Colors.white,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        useMaterial3: true,
      ),
      initialBinding: AllBindings(),
      initialRoute: '/',
      getPages: AppRoutes.pages,
    );
  }
}
