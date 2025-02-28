import 'package:fitness_tracker/models/exercise_ai_model.dart';
import 'package:fitness_tracker/models/exercise_model.dart';
import 'package:fitness_tracker/services/base_service.dart';
import 'package:fitness_tracker/services/constants.dart';

import '../models/body_part_model.dart';
import '../utils/app_exceptions.dart';

class ExerciseService extends BaseService {
  static final ExerciseService _instance = ExerciseService._internal();

  factory ExerciseService() {
    return _instance;
  }

  ExerciseService._internal();

  Future<List<ExerciseModel>> getExerciseByBodyPart(
      {required BodyPartModel bodyPart}) async {
    List<ExerciseModel> result = [];
    await firestore
        .collection(Constants.exerciseCollection)
        .where('Body_Part_Exercire', isEqualTo: bodyPart.toJson())
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(ExerciseModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<List<ExerciseAIModel>> getExerciseForAI() async {
    List<ExerciseAIModel> result = [];
    await firestore.collection(Constants.exerciseCollection).get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(ExerciseAIModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<List<ExerciseModel>> getAllExer() async {
    List<ExerciseModel> result = [];
    await firestore.collection(Constants.exerciseCollection).get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(ExerciseModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }
}
