import 'package:flutter/material.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/date_util.dart';

class DatePickerWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  DateTime? value;
  final double? height;
  final DateTime? lastDate;
  final Function(String?)? validator;
  final Function(DateTime value) onChanged;

  DatePickerWidget(
      {super.key,
      this.hintText,
      this.height,
      this.prefixIcon,
      this.validator,
      this.value,
      required this.onChanged,
      this.lastDate, this.labelText});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    widget.value ??= DateTime.now();
    _controller.text = DateUtil.formatDateNotHH(widget.value!);
    print('init state');
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate;
    if (widget.value != null) {
      selectedDate = widget.value!;
    } else {
      selectedDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2500),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.value = selectedDate;
        _controller.text = DateUtil.formatDateNotHH(selectedDate);
        widget.onChanged(selectedDate);
      });
    }
  }

  OutlineInputBorder _border({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: color ?? AppColors.textColor, width: 1),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _selectDate(context);
      },
      child: SizedBox(
        height: widget.height ?? 59.0,
        child: TextFormField(
          controller: _controller,
          maxLines: 1,
          validator: (widget.validator != null)
              ? (value) {
                  return widget.validator!(value);
                }
              : null,
          textAlignVertical: TextAlignVertical.center,
          enabled: false,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: const TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(124, 124, 124, 1),
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(
                    widget.prefixIcon,
                    color: const Color.fromRGBO(105, 108, 121, 1),
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(56.0),
              borderSide:
                  const BorderSide(color: AppColors.textColor, width: 1),
            ),
            enabledBorder: _border(),
            contentPadding: (widget.height != null)
                ? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0)
                : null,
            focusedErrorBorder: _border(color: Colors.red),
            disabledBorder: _border(),
            focusedBorder: _border(color: AppColors.primaryColor),
            errorBorder: _border(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
