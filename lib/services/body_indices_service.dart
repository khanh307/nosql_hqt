import 'package:fitness_tracker/services/base_service.dart';
import 'package:fitness_tracker/services/constants.dart';
import 'package:fitness_tracker/utils/utils.dart';
import 'package:uuid/uuid_util.dart';

import '../models/body_indices_model.dart';
import '../utils/app_exceptions.dart';

class BodyIndicesService extends BaseService {
  static final BodyIndicesService _instance = BodyIndicesService._internal();

  factory BodyIndicesService() {
    return _instance;
  }

  BodyIndicesService._internal();

  Future<BodyIndicesModel?> createIndices(
      {required BodyIndicesModel indices}) async {
    BodyIndicesModel? result;
    String uuid = Utils.generateUUID();
    indices.id = uuid;

    await firestore
        .collection(Constants.bodyIndicesCollection)
        .doc(uuid)
        .set(indices.toJson())
        .then(
      (value) {
        result = indices;
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }
}
