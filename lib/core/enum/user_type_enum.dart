
enum UserTypeEnum {
  trainer, student, admin
}

extension UserTypeExtension on UserTypeEnum {
  String get value {
    switch (this) {
      case UserTypeEnum.trainer:
        return 'Huấn luyện viên';
      case UserTypeEnum.student:
        return 'Học viên';
      case UserTypeEnum.admin:
        return 'Admin';
    }
  }
}