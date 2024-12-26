import 'package:get/get.dart';

import '../../models/body_part_model.dart';
import '../../models/exercise_model.dart';
import '../../utils/dialog_util.dart';
import '../bottom_nav/bottom_nav_controller.dart';

class ExerciseController extends GetxController {
  static ExerciseController get instants => Get.find();
  BodyPartModel bodyPart = Get.arguments;
  RxList<ExerciseModel> listExercise = <ExerciseModel>[].obs;
  bool isSelected = BottomNavController.instants.isSelected;

  @override
  void onReady() async {
    super.onReady();
    listExercise.value = bodyPart.bodyPartExercise ?? [];
  }

  void pickExercise(ExerciseModel model) {}

  void removeExercise(ExerciseModel model) {}
}
