
import 'package:fitness_tracker/models/body_part_model.dart';
import 'package:fitness_tracker/services/base_service.dart';
import 'package:fitness_tracker/services/constants.dart';

class BodyPartService extends BaseService {
  static final BodyPartService _instance = BodyPartService._internal();

  factory BodyPartService() {
    return _instance;
  }

  BodyPartService._internal();

  Future<List<BodyPartModel>> getAllBodyPart() async {
    List<BodyPartModel> result = [];
    await firestore.collection(Constants.bodyPartCollection).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          result.add(BodyPartModel.fromJson(doc.data()));
        }
      }
    },);
    return result;
  }
}