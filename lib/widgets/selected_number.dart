import 'package:fitness_tracker/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SelectedNumber extends StatefulWidget {
  final Function(double value) onChanged;
  final double value;
  final double valueOnChange;

  const SelectedNumber(
      {super.key,
      required this.onChanged,
      required this.value,
      required this.valueOnChange});

  @override
  State<SelectedNumber> createState() => _SelectedNumberState();
}

class _SelectedNumberState extends State<SelectedNumber> {
  double valueBuild = 0;

  @override
  void initState() {
    valueBuild = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              if (valueBuild >= widget.valueOnChange) {
                setState(() {
                  valueBuild -= widget.valueOnChange;
                });
              } else {
                setState(() {
                  valueBuild = 0;
                });
              }
              widget.onChanged(valueBuild);
            },
            child: const Icon(Icons.remove_circle_outline)),
        const SizedBox(
          width: 8,
        ),
        TextWidget(text: valueBuild.toStringAsFixed(1)),
        const SizedBox(
          width: 8,
        ),
        InkWell(
            onTap: () {
              setState(() {
                valueBuild += widget.valueOnChange;
                widget.onChanged(valueBuild);
              });
            },
            child: const Icon(Icons.add_circle_outline)),
      ],
    );
  }
}
