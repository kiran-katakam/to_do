import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> instantiateSharedPreferencesInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getInt("personalTaskCount") == null) {
      sharedPreferences.setInt("personalTaskCount", 0);
      personalTaskCount = 0;
    } else {
      personalTaskCount = sharedPreferences.getInt("personalTaskCount")!;
    }
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
                  "Date",
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
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Title Required"),
                      showCloseIcon: true,
                    ),
                  );
                } else if (descriptionController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Description Required"),
                      showCloseIcon: true,
                    ),
                  );
                } else if (isRelatedToMoney &&
                    moneyController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Amount Required"),
                      showCloseIcon: true,
                    ),
                  );
                } else if (!isDateModified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please Select a Date"),
                      showCloseIcon: true,
                    ),
                  );
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
