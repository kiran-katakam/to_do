import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/utils.dart';

class PersonalTask extends StatefulWidget {
  const PersonalTask({super.key});

  @override
  State<PersonalTask> createState() => _PersonalTaskState();
}

class _PersonalTaskState extends State<PersonalTask> {
  bool isRelatedToMoney = false;
  late TextEditingController moneyController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late SharedPreferences sharedPreferences;
  late int personalTaskCount;
  late bool isDateModified;
  bool hasError = false;
  final String personalTaskCountKey = "personalTaskCount";
  final String personalTaskKeyPrefix = "personalTask";

  Future<void> instantiateSharedPreferencesInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getInt(personalTaskCountKey) == null) {
      await sharedPreferences.setInt(personalTaskCountKey, 0);
      personalTaskCount = 0;
    } else {
      personalTaskCount = sharedPreferences.getInt(personalTaskCountKey)!;
    }
  }

  void _saveTask() async {
    final task = {
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'isRelatedToMoney': isRelatedToMoney,
      'money': isRelatedToMoney ? moneyController.text.trim() : null,
      'date': toDDMMYYYY(selectedDate),
    };
    await sharedPreferences.setInt(personalTaskCountKey, personalTaskCount + 1);
    await sharedPreferences.setString(
        "$personalTaskKeyPrefix${personalTaskCount + 1}", jsonEncode(task));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task Added Successfully"),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  bool _validateInputs() {
    if (titleController.text.trim().isEmpty) {
      _showSnackBar("Title Required");
      return false;
    }
    if (descriptionController.text.trim().isEmpty) {
      _showSnackBar("Description Required");
      return false;
    }
    if (isRelatedToMoney && moneyController.text.trim().isEmpty) {
      _showSnackBar("Amount Required");
      return false;
    }
    if (!isDateModified) {
      _showSnackBar("Please Select a Date");
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    moneyController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    selectedDate = DateTime.now();
    isDateModified = false;
    instantiateSharedPreferencesInstance();
  }

  @override
  void dispose() {
    moneyController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                label: const Text("Title"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: titleController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TextField(
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  label: const Text("Description"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                textInputAction: TextInputAction.newline,
                controller: descriptionController,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Related to Money? ",
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Switch.adaptive(
                    value: isRelatedToMoney,
                    onChanged: (value) {
                      setState(
                        () {
                          isRelatedToMoney = value;
                          if (!isRelatedToMoney) {
                            moneyController.clear();
                          }
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        label: const Text("Rupees"),
                        prefixIcon: const Icon(Icons.currency_rupee_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(),
                      textInputAction: TextInputAction.next,
                      enabled: isRelatedToMoney,
                      controller: moneyController,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Selected Date",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  child: Text(
                      "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );
                    if (pickedDate != null) {
                      setState(
                        () {
                          selectedDate = pickedDate;
                          isDateModified = true;
                        },
                      );
                    }
                  },
                )
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  _saveTask();
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(150, 50),
                  backgroundColor: const Color.fromRGBO(205, 185, 252, 1),
                  foregroundColor: Colors.black,
                  splashFactory: InkRipple.splashFactory),
              child: const Text(
                "Add Task",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
