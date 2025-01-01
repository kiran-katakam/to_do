import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/providers/taskprovider.dart';
import 'package:to_do/tasks/tasks.dart';
import 'package:to_do/utils.dart';

class PersonalTaskPage extends StatefulWidget {
  const PersonalTaskPage({super.key});

  @override
  State<PersonalTaskPage> createState() => _PersonalTaskPageState();
}

class _PersonalTaskPageState extends State<PersonalTaskPage> {
  bool _isRelatedToMoney = false;
  late TextEditingController _moneyController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late bool _isDateModified;
  late FocusNode _titleFocusNode;

  Future<void> _addTask(WidgetRef ref) async {
    final PersonalTask task = PersonalTask(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      isRelatedToMoney: _isRelatedToMoney,
      money: _isRelatedToMoney ? double.parse(_moneyController.text.trim()) : null,
      dueDate: _selectedDate,
    );
    await ref.read(personalTaskProvider.notifier).addTask(task);
    _showSnackBar("Task Added Successfully");
  }

  bool _validateInputs() {
    if (_titleController.text.trim().isEmpty) {
      _showSnackBar("Title Required");
      return false;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showSnackBar("Description Required");
      return false;
    }
    if (_isRelatedToMoney && _moneyController.text.trim().isEmpty) {
      _showSnackBar("Amount Required");
      return false;
    }
    if (!_isDateModified) {
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

  void resetPage() {
    _moneyController.clear();
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _isRelatedToMoney = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _moneyController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedDate = DateTime.now();
    _isDateModified = false;
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _moneyController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
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
        // backgroundColor: Colors.purple[900],
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
              controller: _titleController,
              focusNode: _titleFocusNode,
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
                controller: _descriptionController,
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
                    value: _isRelatedToMoney,
                    onChanged: (value) {
                      setState(
                        () {
                          _isRelatedToMoney = value;
                          if (!_isRelatedToMoney) {
                            _moneyController.clear();
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
                      enabled: _isRelatedToMoney,
                      controller: _moneyController,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Expected Date",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  child: Text(toDDMMYYYY(_selectedDate)),
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
                          _selectedDate = pickedDate;
                          _isDateModified = true;
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
            Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: () async {
                  if (_validateInputs()) {
                    await _addTask(ref);
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                    resetPage();
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
            ),
          ],
        ),
      ),
    );
  }
}
