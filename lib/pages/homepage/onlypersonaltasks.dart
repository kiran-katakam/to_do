import 'package:flutter/material.dart';
import 'package:to_do/tasks/tasks.dart';
import 'package:to_do/widgets/personaltaskcard.dart';

class OnlyPersonalTasks extends StatelessWidget {
  const OnlyPersonalTasks({super.key, required this.personalTasks});
  final List<PersonalTask> personalTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: personalTasks.length,
      itemBuilder: (context, index) {
        return PersonalTaskCard(task: personalTasks[index]);
      },
    );
  }
}
