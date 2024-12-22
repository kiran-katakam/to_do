import 'package:flutter/material.dart';
import 'package:to_do/widgets/fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 3,
        titleTextStyle: const TextStyle(fontSize: 32, color: Colors.white),
        backgroundColor: Colors.purple[900],
      ),
      floatingActionButton: const FAB()
    );
  }
}
