import 'package:flutter/material.dart';
import 'package:to_do/widgets/personaltaskcard.dart';

class OnlyPersonalTasks extends StatelessWidget {
  const OnlyPersonalTasks({super.key, required this.personalTasks});
  final List<String> personalTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: personalTasks.length,
      itemBuilder: (context, index) {
        return PersonalTaskCard(personalTaskString: personalTasks[index]);
      },
    );
  }
}
