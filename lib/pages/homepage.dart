import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    _loadTasksFuture = ref.read(personalTaskProvider).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final personalTasks = ref.watch(personalTaskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 3,
        titleTextStyle: const TextStyle(fontSize: 32, color: Colors.white),
        backgroundColor: Colors.purple[900],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Consumer(
              builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () {
                    ref.read(personalTaskProvider).removeAllTasks();
                  },
                  child: const Icon(Icons.remove_circle_outline_rounded),
                );
              },
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _loadTasksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (personalTasks.tasks.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Good News:)",
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
            return ListView.builder(
              itemCount: personalTasks.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    personalTasks.tasks[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: const FAB(),
    );
  }
}
