import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/utils.dart';

final taskProvider = ChangeNotifierProvider(
  (ref) => PersonalTasks(),
);

class PersonalTasks extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  List<String> personalTasks = [];
  List<String> academicTasks = [];

  Future<void> _instantiateSharedPreferencesInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> loadTasks() async {
    await _instantiateSharedPreferencesInstance();
    final personalTaskCount = _sharedPreferences?.getInt(personalTaskCountKey) ?? 0;
    final academicTaskCount = _sharedPreferences?.getInt(academicTaskCountKey) ?? 0;
    personalTasks = List.generate(personalTaskCount, (index) {
      return _sharedPreferences
              ?.getString('$personalTaskKeyPrefix${index + 1}') ??
          '';
    });
    academicTasks = List.generate(academicTaskCount, (index) {
      return _sharedPreferences
              ?.getString('$academicTaskCountPrefix${index + 1}') ??
          '';
    });
    notifyListeners();
  }

  Future<void> addPersonalTask(String task) async {
    await _instantiateSharedPreferencesInstance();
    personalTasks.add(task);
    await _sharedPreferences!
        .setString('$personalTaskKeyPrefix${personalTasks.length}', task);
    await _sharedPreferences!.setInt(personalTaskCountKey, personalTasks.length);
    notifyListeners();
  }

  Future<void> addAcademicTask(String task) async {
    await _instantiateSharedPreferencesInstance();
    academicTasks.add(task);
    await _sharedPreferences!
        .setString('$academicTaskCountPrefix${academicTasks.length}', task);
    await _sharedPreferences!.setInt(academicTaskCountKey, academicTasks.length);
    notifyListeners();
  }

  Future<void> removeAllTasks() async {
    await _instantiateSharedPreferencesInstance();
    personalTasks.clear();
    academicTasks.clear();
    await _sharedPreferences!.setInt(personalTaskCountKey, 0);
    await _sharedPreferences!.setInt(academicTaskCountKey, 0);
    notifyListeners();
  }
}
