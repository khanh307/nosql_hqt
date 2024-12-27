import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat _format = DateFormat('HH:mm dd/MM/yyyy ');
  static final DateFormat _format2 = DateFormat('dd/MM/yyyy');
  static final DateFormat _format3 = DateFormat('yyyy-MM-dd');
  static final DateFormat _format4 = DateFormat('HH:mm');
  static final DateFormat _format5 = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
  static final DateFormat _format6 = DateFormat('EEEE', 'vi');
  static final DateFormat _format7 = DateFormat('dd/MM/yy');

  static String formatDate(DateTime date) {
    return _format.format(date);
  }

  static String formatDateNotHH(DateTime date) {
    return _format2.format(date);
  }

  static String formatDate7(DateTime date) {
    return _format7.format(date);
  }

  static String formatThu(DateTime date, [bool formatShort = true]) {
    final dayOfWeek = _format6.format(date);
    print('dayOfWeek $dayOfWeek');
    if (!formatShort) {
      return dayOfWeek;
    }
    switch (dayOfWeek.toLowerCase()) {
      case 'thứ hai':
        return 'T.2';
      case 'thứ ba':
        return 'T.3';
      case 'thứ tư':
        return 'T.4';
      case 'thứ năm':
        return 'T.5';
      case 'thứ sáu':
        return 'T.6';
      case 'thứ bảy':
        return 'T.7';
      case 'chủ nhật':
        return 'CN';
      default:
        return 'T.2';
    }
  }

  static String formatDateFromString(String string) {
    if (string.isEmpty || string == '') return '';
    DateTime date = DateTime.parse(string);
    return _format.format(date);
  }

  static String formatDateFromStringNotHH(String string) {
    if (string.isEmpty || string == '') return '';
    DateTime date = DateTime.parse(string);
    return _format2.format(date);
  }

  static String formatDateYYYY(DateTime date) {
    return _format3.format(date);
  }

  static String formatDateNotDD(String string) {
    if (string.isEmpty || string == '') return '';
    String year = '';
    String month = '';
    if (string.length > 5) {
      year = string.substring(2);
      month = string.substring(0, 2);
    } else {
      year = string.substring(1);
      month = '0${string.substring(0, 1)}';
    }
    return 'Tháng $month-$year';
  }

  static String formatTime(DateTime date) {
    return _format4.format(date);
  }

  static String formatDatePost(DateTime time) {
    return _format5.format(time);
  }

  static DateTime parse(String input) {
    return _format2.parse(input);
  }
}
