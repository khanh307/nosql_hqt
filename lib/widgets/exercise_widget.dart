//
//
// import 'package:fitness_tracker/models/calendar_model.dart';
// import 'package:fitness_tracker/models/exercise_model.dart';
// import 'package:fitness_tracker/widgets/custom_container.dart';
// import 'package:fitness_tracker/widgets/selected_number.dart';
// import 'package:fitness_tracker/widgets/text_widget.dart';
// import 'package:flutter/material.dart';
//
// import '../models/exercise_picked_model.dart';
// import '../utils/const/app_colors.dart';
//
// class ExerciseWidget extends StatefulWidget {
//   final CalendarModel calendar;
//   final ExerciseModel exercise;
//   final bool isExpended;
//   final Function(CalendarModel calendar, ExerciseModel exercise) onTap;
//
//   const ExerciseWidget(
//       {super.key,
//       required this.calendar,
//       this.isExpended = false,
//       required this.exercise, required this.onTap});
//
//   @override
//   State<ExerciseWidget> createState() => _ExerciseWidgetState();
// }
//
// class _ExerciseWidgetState extends State<ExerciseWidget> {
//   bool isExpend = false;
//   double value = 5;
//   double valueChange = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     isExpend = widget.isExpended;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomContainer(
//           onTap: () {
//             widget.onTap(widget.calendar, widget.exercise);
//           },
//           padding: EdgeInsets.zero,
//           child: Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//                 height: 30,
//               ),
//               Expanded(
//                 child: TextWidget(
//                   text: widget.exercise.name ?? '',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isExpend = !isExpend;
//                   });
//                 },
//                 icon: Icon(
//                   (isExpend)
//                       ? Icons.arrow_drop_up
//                       : Icons.arrow_drop_down_sharp,
//                 ),
//                 padding: EdgeInsets.zero,
//               ),
//             ],
//           ),
//         ),
//         AnimatedContainer(
//             height: isExpend ? null : 0,
//             margin: const EdgeInsets.only(left: 4.0, right: 4.0),
//             padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                   left: BorderSide(color: AppColors.borderContainer, width: 1),
//                   right: BorderSide(color: AppColors.borderContainer, width: 1),
//                   bottom:
//                       BorderSide(color: AppColors.borderContainer, width: 1)),
//             ),
//             duration: const Duration(milliseconds: 800),
//             curve: Curves.fastOutSlowIn,
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     const TextWidget(
//                       text: 'Số kg: ',
//                       textAlign: TextAlign.center,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SelectedNumber(
//                       value: value,
//                       valueOnChange: 1,
//                       onChanged: (double value) {
//                         setState(() {
//                           this.value = value;
//                         });
//                       },
//                     ),
//                     const TextWidget(
//                       text: ' + ',
//                       textAlign: TextAlign.center,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     SelectedNumber(
//                       value: valueChange,
//                       valueOnChange: 0.1,
//                       onChanged: (double value) {
//                         setState(() {
//                           valueChange = value;
//                         });
//                       },
//                     ),
//                     TextWidget(
//                       text: ' = ${value + valueChange} ',
//                       textAlign: TextAlign.center,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5,),
//                 const Row(
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: TextWidget(
//                           text: 'Số Sets',
//                           textAlign: TextAlign.center,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     Expanded(
//                         flex: 3,
//                         child: TextWidget(
//                           text: 'Số Reps',
//                           textAlign: TextAlign.center,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     Expanded(flex: 1, child: SizedBox())
//                   ],
//                 ),
//                 ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                   flex: 1,
//                                   child: TextWidget(
//                                     text: '${index + 1}',
//                                     textAlign: TextAlign.center,
//                                     fontWeight: FontWeight.bold,
//                                   )),
//                               Expanded(
//                                 flex: 3,
//                                 child: SelectedNumber(
//                                   value: double.parse(widget.calendar
//                                       .exerciseId![widget.exercise.id!]![index]
//                                       .toString()),
//                                   valueOnChange: value + valueChange,
//                                   onChanged: (double value) {
//                                     setState(() {
//                                       widget.calendar.exerciseId![
//                                           widget.exercise.id!]![index] = value;
//                                     });
//                                   },
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: IconButton(
//                                     onPressed: () {
//                                       widget.calendar
//                                           .exerciseId![widget.exercise.id]!
//                                           .removeAt(index);
//                                       setState(() {});
//                                     },
//                                     icon: const Icon(
//                                         Icons.remove_circle_outline)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return const SizedBox(
//                         height: 10,
//                       );
//                     },
//                     itemCount: widget
//                         .calendar.exerciseId![widget.exercise.id!]!.length),
//                 IconButton(
//                     onPressed: () {
//                       widget.calendar.exerciseId![widget.exercise.id]!.add(10);
//                       setState(() {});
//                     },
//                     icon: const Icon(Icons.add_circle_outline))
//               ],
//             ))
//       ],
//     );
//   }
// }
