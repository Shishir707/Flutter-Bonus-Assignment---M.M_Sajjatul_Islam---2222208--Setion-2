import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_management_provider.dart';
import '../utils/validators.dart';
import '../widgets/core_input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late TaskManagementProvider taskProvider;

  get Provider => null;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<TaskManagementProvider>();
    });
  }

  @override
  void dispose() {
    _idController.clear();
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/add_task.png",
                width: 500,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                "Enter Your New Task",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CoreInputField(
                controller: _idController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                labelText: "Enter ID",
                validator: CustomValidators.validateTaskTitle,
              ),
              const SizedBox(height: 40),
              CoreInputField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                labelText: "Task Title",
                validator: CustomValidators.validateTaskTitle,
              ),

              const SizedBox(height: 40),
              CoreInputField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                labelText: "Task Description",
                validator: CustomValidators.validateDescription,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final String taskDetails =
                  "Title: ${_titleController.text} \nDescription: ${_descriptionController.text} \n";

              OnTapAddButton();

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Task added successfully!,",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text("Add Task"),
        ),
      ),
    );
  }

  Future<void> OnTapAddButton() async {
    final firestore = FirebaseFirestore.instance;

    final String customId = _titleController.text.trim();

    await firestore.collection('task').doc(customId).set({
      'title': _titleController.text.trim(),
      'subtitle': _descriptionController.text.trim(),
      'createdAt': DateTime.now().toIso8601String(),
    });
  }
}
