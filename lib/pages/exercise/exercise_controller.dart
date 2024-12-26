import 'package:fitness_tracker/services/exercise_service.dart';
import 'package:get/get.dart';

import '../../models/body_part_model.dart';
import '../../models/exercise_model.dart';
import '../../utils/dialog_util.dart';
import '../bottom_nav/bottom_nav_controller.dart';

class ExerciseController extends GetxController {
  static ExerciseController get instants => Get.find();
  BodyPartModel bodyPart = Get.arguments;
  RxList<ExerciseModel> listExercise = <ExerciseModel>[].obs;
  final ExerciseService _exerciseService = ExerciseService();

  @override
  void onReady() async {
    super.onReady();
    await _getAllExercise();
  }

  Future _getAllExercise() async {
    DialogUtil.showLoading();
    try {
      await _exerciseService.getExerciseByBodyPart(bodyPart: bodyPart).then((value) {
        listExercise.addAll(value);
        DialogUtil.hideLoading();
      },);
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }

  void pickExercise(ExerciseModel model) {}

  void removeExercise(ExerciseModel model) {}
}
