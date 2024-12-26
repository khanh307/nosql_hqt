import 'package:fitness_tracker/models/student_model.dart';
import 'package:fitness_tracker/models/traniner_model.dart';
import 'package:fitness_tracker/models/user_model.dart';
import 'package:fitness_tracker/services/base_service.dart';
import 'package:fitness_tracker/services/constants.dart';

import '../utils/app_exceptions.dart';
import '../utils/utils.dart';

class UserService extends BaseService {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  Future<bool> createStudent({required StudentModel student}) async {
    bool result = false;

    await firestore
        .collection(Constants.userCollection)
        .where(Constants.phone, isEqualTo: student.usersStudent!.phone)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          throw NotFoundException('User đã tồn tại');
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });

    String uuid = Utils.generateUUID();
    student.id = uuid;
    student.usersStudent!.id = uuid;
    student.id = uuid;
    await firestore
        .collection(Constants.studentCollection)
        .doc(uuid)
        .set(student.toJson())
        .then(
      (value) async {
        await firestore
            .collection(Constants.userCollection)
            .doc(uuid)
            .set(student.usersStudent!.toJson())
            .then((value) async {
          result = true;
        }).onError((error, stackTrace) {
          throw BadRequestException(error.toString());
        });
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });

    return result;
  }

  Future<bool> createTrainer({required TrainerModel trainer}) async {
    bool result = false;

    await firestore
        .collection(Constants.userCollection)
        .where(Constants.phone, isEqualTo: trainer.usersTraner!.phone)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          throw NotFoundException('User đã tồn tại');
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });

    String uuid = Utils.generateUUID();
    trainer.id = uuid;
    trainer.usersTraner!.id = uuid;
    trainer.id = uuid;
    await firestore
        .collection(Constants.trainerCollection)
        .doc(uuid)
        .set(trainer.toJson())
        .then(
      (value) async {
        await firestore
            .collection(Constants.userCollection)
            .doc(uuid)
            .set(trainer.usersTraner!.toJson())
            .then((value) async {
          result = true;
        }).onError((error, stackTrace) {
          throw BadRequestException(error.toString());
        });
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });

    return result;
  }

  Future<UserModel?> getUserByUserNameAndPassword(
      {required String username, required String password}) async {
    UserModel? result;

    await firestore
        .collection(Constants.userCollection)
        .where(Constants.phone, isEqualTo: username)
        .where(Constants.password, isEqualTo: password)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        throw NotFoundException('Tài khoản hoặc mật khẩu không đúng');
      }
      result = await getTrainerById(value.docs.first.id);
      result ??= await getStudentById(value.docs.first.id);
      result ??= UserModel.fromJson(value.docs.first.data());
    }).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<TrainerModel?> getTrainerById(String id) async {
    TrainerModel? model;
    await firestore.collection(Constants.trainerCollection).doc(id).get().then(
      (value) {
        if (value.exists) {
          model = TrainerModel.fromJson(value.data());
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return model;
  }

  Future<StudentModel?> getStudentById(String id) async {
    StudentModel? model;
    await firestore.collection(Constants.studentCollection).doc(id).get().then(
      (value) {
        if (value.exists) {
          model = StudentModel.fromJson(value.data());
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return model;
  }

  Future<List<StudentModel>> getAllStudent() async {
    List<StudentModel> result = [];
    await firestore.collection(Constants.studentCollection).get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(StudentModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }

  Future<List<UserModel>> getStudentByIdNotIn(
      {required List<String> listId}) async {
    List<UserModel> result = [];
    await firestore
        .collection(Constants.userCollection)
        .where('ID', whereNotIn: listId)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          for (var doc in value.docs) {
            result.add(UserModel.fromJson(doc.data()));
          }
        }
      },
    ).onError((error, stackTrace) {
      throw BadRequestException(error.toString());
    });
    return result;
  }
}
