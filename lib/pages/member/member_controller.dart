import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/pages/bottom_nav/bottom_nav_controller.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:fitness_tracker/utils/dialog_util.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  static MemberController get instants => Get.find();
  bool isSelected = BottomNavController.instants.isSelected;
  RxList<StudentModel> listMember = <StudentModel>[].obs;
  final UserService _userServices = UserService();

  @override
  void onReady() async {
    super.onReady();
    await getAllMember();
  }

  Future getAllMember() async {
    await DialogUtil.showLoading();
    try {
      List<StudentModel> result = await _userServices.getAllStudent();
      listMember.addAll(result);
      DialogUtil.hideLoading();
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: e.toString());
    }
  }


}
