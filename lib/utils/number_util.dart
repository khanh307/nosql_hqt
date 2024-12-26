import 'package:intl/intl.dart';

class NumberUtils {
  static final _formatterNumber =
      NumberFormat.currency(locale: 'vi_VN', symbol: '');

  static String formatNumber(num input) {
    return _formatterNumber.format(input);
  }

  static num parseString(String input) {
    return _formatterNumber.parse(input);
  }
}
