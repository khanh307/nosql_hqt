
class ValidationTextForm {
  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Thông tin bắt buộc';
    }
    return null;
  }
}