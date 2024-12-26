
import 'package:fitness_tracker/services/body_part_service.dart';
import 'package:get/get.dart';

import '../../models/body_part_model.dart';
import '../../utils/dialog_util.dart';

class BodyPartController extends GetxController {
  static BodyPartController get instants => Get.find();

  RxList<BodyPartModel> listBodyPart = <BodyPartModel>[].obs;
  final BodyPartService _bodyPartService = BodyPartService();

  @override
  void onReady() async {
    super.onReady();
    await getAllBodyPart();
  }

  Future getAllBodyPart() async {
    await DialogUtil.showLoading();
    try {
      var result = await _bodyPartService.getAllBodyPart();
      listBodyPart.addAll(result);
      DialogUtil.hideLoading();
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }
}
