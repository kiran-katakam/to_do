import 'package:flutter/material.dart';

class AcademicTask extends StatelessWidget {
  const AcademicTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Academic Task"),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 3,
        titleTextStyle: const TextStyle(fontSize: 28, color: Colors.white),
        backgroundColor: Colors.purple[900],
      ),
    );
  }
}