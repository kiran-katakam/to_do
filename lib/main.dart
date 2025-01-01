import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/pages/homepage/homepage.dart';
import 'package:to_do/tasks/tasks.dart';
import 'package:to_do/utils.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AcademicTaskAdapter());
  Hive.registerAdapter(PersonalTaskAdapter());
  await Hive.openBox<PersonalTask>(personalTaskBoxString);
  await Hive.openBox<AcademicTask>(academicTaskBoxString);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
