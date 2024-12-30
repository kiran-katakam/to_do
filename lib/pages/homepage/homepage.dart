import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/pages/homepage/bothepersonalandacademictask.dart';
import 'package:to_do/pages/homepage/homepageappbar.dart';
import 'package:to_do/pages/homepage/onlyacademictasks.dart';
import 'package:to_do/pages/homepage/onlypersonaltasks.dart';
import 'package:to_do/providers/taskprovider.dart';
import 'package:to_do/widgets/fab.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<void> _loadTasksFuture;

  @override
  void initState() {
    super.initState();
    _loadTasksFuture = ref.read(taskProvider).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: const HomePageAppBar(),
      body: FutureBuilder(
        future: _loadTasksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (tasks.personalTasks.isEmpty && tasks.academicTasks.isEmpty) {
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
            }

            if (tasks.academicTasks.isEmpty) {
              return OnlyPersonalTasks(personalTasks: tasks.personalTasks);
            }
            if (tasks.personalTasks.isEmpty) {
              return OnlyAcademicTasks(academicTasks: tasks.academicTasks);
            }
            return BothPersonalAndAcademicTasks(
              personalTasks: tasks.personalTasks,
              academicTasks: tasks.academicTasks,
            );
          }
        },
      ),
      floatingActionButton: const FAB(),
    );
  }
}
