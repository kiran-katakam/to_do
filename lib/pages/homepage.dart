import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/providers/taskprovider.dart';
import 'package:to_do/widgets/fab.dart';
import 'package:to_do/widgets/personaltaskcard.dart';

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
        // backgroundColor: Colors.purple[900],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Consumer(
              builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () {
                    if (personalTasks.tasks.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nothing to Clear"),
                          showCloseIcon: true,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          title: const Text("Delete all Tasks"),
                          content: const Text(
                              "Are you Sure you want to delete all Tasks?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await ref
                                    .read(personalTaskProvider)
                                    .removeAllTasks();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
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
            return ListView.builder(
              itemCount: personalTasks.tasks.length,
              itemBuilder: (context, index) {
                return PersonalTaskCard(
                  taskString: personalTasks.tasks[index],
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
