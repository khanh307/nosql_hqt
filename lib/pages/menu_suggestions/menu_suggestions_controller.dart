import 'package:fitness_tracker/models/body_indices_model.dart';
import 'package:fitness_tracker/services/body_indices_service.dart';
import 'package:fitness_tracker/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:openai_dart/openai_dart.dart';

import '../../core/singleton.dart';
import '../../models/student_model.dart';
import '../../models/user_model.dart';
import '../../utils/dialog_util.dart';

class MenuSuggestionsController extends GetxController {
  UserService _userService = UserService();
  UserModel user = Singleton().user!;
  Rx<StudentModel?> student = Rx(null);

  final client = OpenAIClient(apiKey: dotenv.env['API_KEY_GPT']);
  RxString resultAI = ''.obs;
  PageController pageController = PageController(initialPage: 0);

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bodyFatController = TextEditingController();
  TextEditingController muscleController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController ageController = TextEditingController(text: '20');
  TextEditingController workController = TextEditingController();

  RxString work = 'Làm việc văn phòng'.obs;

  Future _getStudentIndices() async {
    await DialogUtil.showLoading();
    try {
      await _userService.getStudentById(user.id!).then(
            (value) {
          if (value != null) {
            student.value = value;
            if (student.value!.usersStudent!.birthday != null) {
              ageController.text = (DateTime.now().year - student.value!.usersStudent!.birthday!.year).toString();
            }
            print('studentBodyIndices ${student.value!.studentBodyIndices}');
            DialogUtil.hideLoading();
          }
        },
      );
    } catch (e) {
      DialogUtil.hideLoading();
      DialogUtil.showDialogError(text: 'Lỗi lấy lịch sử chỉ số cơ thể của người dùng');
    }

  }

  @override
  void onInit() {
    super.onInit();
    heightController.addListener(
          () {
        updateBMI();
      },
    );
    weightController.addListener(
          () {
        updateBMI();
      },
    );
  }

  void updateBMI() {
    if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
      num weight = double.tryParse(weightController.text) ?? 0;
      num height = double.tryParse(heightController.text) ?? 0;
      bmiController.text =
          (weight / ((height / 100) * (height / 100))).toStringAsFixed(1);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await _getStudentIndices();
  }

  Future suggesMenu() async {
    DialogUtil.showLoading();
    // try {
      BodyIndicesModel? body;
      if (student.value != null && student.value!.studentBodyIndices != null && student.value!.studentBodyIndices!.isNotEmpty) {
        body = student.value!.studentBodyIndices!.last;
      }

      body ??= BodyIndicesModel(
          bmi: double.tryParse(bmiController.text) ?? 0,
          bodyFat: double.tryParse(bodyFatController.text) ?? 0,
          height: double.tryParse(heightController.text) ?? 0,
          muscle: double.tryParse(muscleController.text) ?? 0,
          weight: double.tryParse(weightController.text) ?? 0);

      if (work.value == 'Khác') {
        work.value = ageController.text;
      }

      final prompt = '''Hãy gợi ý thực đơn gym 1 ngày cho tôi, 
       giới tính ${(student.value!.sex ?? false) ? 'Nam' : 'Nữ'}, 
       tuổi của tôi ${ageController.text},
       công việc hằng ngày của tôi ${work.value},
      với chỉ số body của tôi là ${body.toJson()}.
      Chỉ trả về định dạng HTML (có css), không trả văn bản khác. 
    ''';
      final res = await client.createChatCompletion(
          request: CreateChatCompletionRequest(
              model: const ChatCompletionModel.modelId('gpt-4o'),
              messages: [
                ChatCompletionMessage.user(
                    content: ChatCompletionUserMessageContent.string(prompt)
                )
              ]));
      resultAI.value = res.choices.first.message.content ?? '';
      resultAI.value = resultAI.value.replaceAll('```', '');
      resultAI.value = resultAI.value.replaceFirst('html', '');
      resultAI.value = resultAI.value.replaceAll(RegExp(r'<title>.*?</title>'), '');
      DialogUtil.hideLoading();
      pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    // } catch (e) {
    //   DialogUtil.hideLoading();
    //   DialogUtil.showDialogError(text: 'Lỗi trong quá trình gợi ý thực đơn');
    // }
  }
}
