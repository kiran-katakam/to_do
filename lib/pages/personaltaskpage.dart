import 'package:flutter/material.dart';

class PersonalTask extends StatelessWidget {
  const PersonalTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Personal Task"),
        centerTitle: true,
        shadowColor: Colors.black,
        elevation: 3,
        titleTextStyle: const TextStyle(fontSize: 28, color: Colors.white),
        backgroundColor: Colors.purple[900],
      ),
    );
  }
}