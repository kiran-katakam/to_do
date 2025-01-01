import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/providers/taskprovider.dart';
import 'package:to_do/tasks/tasks.dart';

class AcademicTaskPage extends StatefulWidget {
  const AcademicTaskPage({super.key});

  @override
  State<AcademicTaskPage> createState() => _AcademicTaskPageState();
}

class _AcademicTaskPageState extends State<AcademicTaskPage> {
  late TextEditingController _courseController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late bool _isDateModified;
  late FocusNode _courseFocusNode;

  Future<void> _addTask(WidgetRef ref) async {
    final AcademicTask task = AcademicTask(
      courseCode: _courseController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: _selectedDate,
    );

    await ref.read(academicTaskProvider.notifier).addTask(task);
    _showSnackBar("Task Added Successfully");
  }

  bool _validateInputs() {
    if (_courseController.text.trim().isEmpty) {
      _showSnackBar("Title Required");
      return false;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showSnackBar("Description Required");
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
    _courseController.clear();
    _descriptionController.clear();
  }

  @override
  void initState() {
    super.initState();
    _courseController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedDate = DateTime.now();
    _isDateModified = false;
    _courseFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _courseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Academic Task"),
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
                label: const Text("Course"),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              controller: _courseController,
              focusNode: _courseFocusNode,
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
            const Padding(padding: EdgeInsets.all(8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Last Date",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  child: Text(
                      "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}"),
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
                    FocusScope.of(context).requestFocus(_courseFocusNode);
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
