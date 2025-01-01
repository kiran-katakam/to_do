import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/pages/homepage/bothepersonalandacademictask.dart';
import 'package:to_do/pages/homepage/homepageappbar.dart';
import 'package:to_do/pages/homepage/onlyacademictasks.dart';
import 'package:to_do/pages/homepage/onlypersonaltasks.dart';
import 'package:to_do/providers/taskprovider.dart';
import 'package:to_do/widgets/fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const HomePageAppBar(),
      body: Consumer(
        builder: (context, ref, child) {   
          return _scaffoldBody(ref);
        },
      ),
      floatingActionButton: const FAB(),
    );
  }

  Widget _scaffoldBody(WidgetRef ref) {
    
    ref.read(personalTaskProvider.notifier).loadTasks();
    ref.read(academicTaskProvider.notifier).loadTasks(); 
    final personalTasks = ref.watch(personalTaskProvider);
    final academicTasks = ref.watch(academicTaskProvider);

    if (personalTasks.personalTasks.isEmpty &&
        academicTasks.academicTasks.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Good News :)",
              style: TextStyle(fontSize: 40),
            ),
            Text(
              "No Pending Tasks",
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      );
    } else if (personalTasks.personalTasks.isEmpty) {
      return OnlyAcademicTasks(academicTasks: academicTasks.academicTasks);
    } else if (academicTasks.academicTasks.isEmpty) {
      return OnlyPersonalTasks(personalTasks: personalTasks.personalTasks);
    } else {
      return BothPersonalAndAcademicTasks(
          academicTasks: academicTasks.academicTasks,
          personalTasks: personalTasks.personalTasks);
    }
  }
}
