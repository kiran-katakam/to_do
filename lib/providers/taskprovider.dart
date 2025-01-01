import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/tasks/tasks.dart';
import 'package:to_do/utils.dart';

final personalTaskProvider = ChangeNotifierProvider((ref) => PersonalTasks());
final academicTaskProvider = ChangeNotifierProvider((ref) => AcademicTasks());

class PersonalTasks extends ChangeNotifier {

  List<PersonalTask> personalTasks = [];

  void loadTasks() {
    Box box = Hive.box<PersonalTask>(personalTaskBoxString);
    personalTasks = List<PersonalTask>.from(box.values);
  }

  Future<void> addTask(PersonalTask task) async {
    Box box = Hive.box<PersonalTask>(personalTaskBoxString);
    await box.add(task);
    personalTasks.add(task);
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    Box box = Hive.box<PersonalTask>(personalTaskBoxString);
    await box.deleteAt(index);
    personalTasks.removeAt(index);
    notifyListeners();
  }
}

class AcademicTasks extends ChangeNotifier {

  List<AcademicTask> academicTasks = [];

  void loadTasks() {
    Box box = Hive.box<AcademicTask>(academicTaskBoxString);
    academicTasks = List<AcademicTask>.from(box.values);
  }

  Future<void> addTask(AcademicTask task) async {
    Box box = Hive.box<AcademicTask>(academicTaskBoxString);
    await box.add(task);
    academicTasks.add(task);
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    Box box = Hive.box<AcademicTask>(academicTaskBoxString);
    await box.deleteAt(index);
    academicTasks.removeAt(index);
    notifyListeners();
  }
}
