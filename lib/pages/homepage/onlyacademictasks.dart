import 'package:flutter/material.dart';
import 'package:to_do/tasks/tasks.dart';
import 'package:to_do/widgets/academictaskcard.dart';

class OnlyAcademicTasks extends StatelessWidget {
  const OnlyAcademicTasks({super.key, required this.academicTasks});
  final List<AcademicTask> academicTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: academicTasks.length,
      itemBuilder: (context, index) {
      return AcademicTaskCard(task: academicTasks[index]);
    },);
  }
}