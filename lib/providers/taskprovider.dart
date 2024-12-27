import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/utils.dart';

final personalTaskProvider = ChangeNotifierProvider(
  (ref) => PersonalTasks(),
);

class PersonalTasks extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;
  List<String> tasks = [];

  Future<void> _instantiateSharedPreferencesInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> loadTasks() async {
    await _instantiateSharedPreferencesInstance();
    final count = _sharedPreferences?.getInt(personalTaskCountKey) ?? 0;
    tasks = List.generate(count, (index) {
      return _sharedPreferences
              ?.getString('$personalTaskKeyPrefix${index + 1}') ??
          '';
    });
    notifyListeners();
  }

  Future<void> addTask(String task) async {
    await _instantiateSharedPreferencesInstance();
    tasks.add(task);
    await _sharedPreferences!
        .setString('$personalTaskKeyPrefix${tasks.length}', task);
    await _sharedPreferences!.setInt(personalTaskCountKey, tasks.length);
    notifyListeners();
  }

  Future<void> removeAllTasks() async {
    await _instantiateSharedPreferencesInstance();
    tasks.clear();
    await _sharedPreferences!.setInt(personalTaskCountKey, 0);
    notifyListeners();
  }
}
