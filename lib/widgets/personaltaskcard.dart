import 'package:flutter/material.dart';
import 'package:to_do/tasks/tasks.dart';
import 'package:to_do/utils.dart';

class PersonalTaskCard extends StatelessWidget {
  const PersonalTaskCard({super.key, required this.task});
  final PersonalTask task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Card(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    toDDMMYYYY(task.dueDate),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  task.isRelatedToMoney
                      ? Text(
                          "₹ ${task.money}",
                          style: const TextStyle(fontSize: 20),
                        )
                      : const SizedBox.shrink()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
