

class ValidationEditText {
  static String? validationRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Thông tin bắt buộc';
    }
    return null;
  }
}