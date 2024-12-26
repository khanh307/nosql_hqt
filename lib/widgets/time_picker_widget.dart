import 'package:flutter/material.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/utils/date_util.dart';

class TimePickerWidget extends StatefulWidget {
  final String? hintText;
  final IconData? prefixIcon;
  TimeOfDay? value;
  final double? height;
  final Function(String?)? validator;
  final Function(TimeOfDay value) onChanged;

  TimePickerWidget(
      {super.key,
      this.hintText,
      this.height,
      this.prefixIcon,
      this.validator,
      this.value,
      required this.onChanged});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    print('value ${widget.value}');
    widget.value ??= TimeOfDay.now();
    if (widget.value!.minute < 10) {
      _controller.text = '${widget.value!.hour}:0${widget.value!.minute}';
    } else {
      _controller.text = '${widget.value!.hour}:${widget.value!.minute}';
    }
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    TimeOfDay selectedDate;
    if (widget.value != null) {
      selectedDate = widget.value!;
    } else {
      selectedDate = TimeOfDay.now();
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox(),
        );
      },
      initialTime: widget.value ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.value = selectedDate;
        if (selectedDate.minute < 10) {
          _controller.text = '${selectedDate.hour}:0${(selectedDate.minute)}';
        } else {
          _controller.text = '${selectedDate.hour}:${(selectedDate.minute)}';
        }
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
    if (widget.value!.minute < 10) {
      _controller.text = '${widget.value!.hour}:0${(widget.value!.minute)}';
    } else {
      _controller.text = '${widget.value!.hour}:${(widget.value!.minute)}';
    }
    return GestureDetector(
      onTap: () async {
        await _selectDate(context);
      },
      child: SizedBox(
        height: widget.height ?? 59.0,
        child: TextFormField(
          controller: _controller,
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
            border: _border(),
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
