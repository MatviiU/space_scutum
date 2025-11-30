import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_scutum/features/tasks/domain/entities/task_entity.dart';
import 'package:space_scutum/features/tasks/presentation/bloc/tasks_cubit.dart';

class TaskFormPage extends StatefulWidget {
  const TaskFormPage({super.key});

  @override
  State<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Create Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: .bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const .all(24.0),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      _buildLabel('Title'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        textCapitalization: .sentences,
                        decoration: _inputDecoration(hint: 'Enter task title'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildLabel('Category'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _categoryController,
                        textCapitalization: TextCapitalization.words,
                        decoration: _inputDecoration(
                          hint: 'e.g. Work, Personal, Gym',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildLabel('Description'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        textCapitalization: .sentences,
                        maxLines: 5,
                        decoration: _inputDecoration(
                          hint: 'Add a description...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const .all(24.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: .infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E88EF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save Task',
                          style: TextStyle(fontSize: 16, fontWeight: .bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF2E88EF),
                          fontSize: 16,
                          fontWeight: .w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final newTask = TaskEntity(
        taskId: 0, // Placeholder: The DB generates the actual ID (AutoIncrement)
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _categoryController.text.trim(),
        isCompleted: false,
      );
      context.read<TasksCubit>().addTask(newTask);
      context.pop();
    }
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: .w600,
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const .symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: const BorderSide(color: Color(0xFF2E88EF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
