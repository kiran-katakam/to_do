import 'package:flutter/material.dart';
import 'package:to_do/pages/homepage/onlyacademictasks.dart';
import 'package:to_do/pages/homepage/onlypersonaltasks.dart';
import 'package:to_do/tasks/tasks.dart';

class BothPersonalAndAcademicTasks extends StatefulWidget {
  const BothPersonalAndAcademicTasks(
      {super.key, required this.academicTasks, required this.personalTasks});

  final List<AcademicTask> academicTasks;
  final List<PersonalTask> personalTasks;

  @override
  State<BothPersonalAndAcademicTasks> createState() =>
      _BothPersonalAndAcademicTasksState();
}

class _BothPersonalAndAcademicTasksState
    extends State<BothPersonalAndAcademicTasks> {
  bool academicIsExpanded = true;
  bool personalIsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
        child: ExpansionPanelList(
          materialGapSize: 0,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              panelIndex == 0
                  ? academicIsExpanded = !academicIsExpanded
                  : personalIsExpanded = !personalIsExpanded;
            });
          },
          expandIconColor: const Color.fromRGBO(205, 185, 252, 1),
          expandedHeaderPadding: const EdgeInsets.all(0),
          animationDuration: const Duration(milliseconds: 500),
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: academicIsExpanded,
              headerBuilder: (context, isExpanded) {
                return const Text(
                  "Academic Tasks",
                  style: TextStyle(fontSize: 24),
                );
              },
              body: OnlyAcademicTasks(academicTasks: widget.academicTasks),
            ),
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded: personalIsExpanded,
              headerBuilder: (context, isExpanded) {
                return const Text(
                  "Personal Tasks",
                  style: TextStyle(fontSize: 24),
                );
              },
              body: OnlyPersonalTasks(personalTasks: widget.personalTasks),
            ),
          ],
        ),
      ),
    );
  }
}
