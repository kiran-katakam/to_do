import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/providers/taskprovider.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                  final tasks = ref.watch(taskProvider);
                  if (tasks.personalTasks.isEmpty && tasks.academicTasks.isEmpty) {
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
                                  .read(taskProvider)
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
    );
  }
}
