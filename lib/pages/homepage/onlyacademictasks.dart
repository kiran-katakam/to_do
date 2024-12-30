import 'package:flutter/material.dart';
import 'package:to_do/widgets/academictaskcard.dart';

class OnlyAcademicTasks extends StatelessWidget {
  const OnlyAcademicTasks({super.key, required this.academicTasks});
  final List<String> academicTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: academicTasks.length,
      itemBuilder: (context, index) {
      return AcademicTaskCard(taskString: academicTasks[index]);
    },);
  }
}