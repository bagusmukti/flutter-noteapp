import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/domain/entities/note.dart';
import 'package:note/data/models/note_model.dart';
import '../bloc/note_bloc.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);
      final bloc = context.read<NoteBloc>();
      // Use NoteModel to match repository expectation
      bloc.add(
        CreateNoteEvent(
          NoteModel(
            title: _titleController.text,
            content: _contentController.text,
            createdAt: DateTime.now(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is NoteLoaded && _isSubmitting) {
          setState(() => _isSubmitting = false);
          Navigator.of(context).pop();
        } else if (state is NoteError && _isSubmitting) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create note: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF181818),
        appBar: AppBar(
          backgroundColor: const Color(0xFF181818),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Create Note',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                    filled: false,
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Title required' : null,
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDate(DateTime.now()),
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: TextFormField(
                    controller: _contentController,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: 'Type something...',
                      hintStyle: TextStyle(color: Colors.white38, fontSize: 17),
                      border: InputBorder.none,
                      filled: false,
                    ),
                    maxLines: null,
                    expands: true,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Content required'
                        : null,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _isSubmitting ? null : () => _submit(context),
                    child: _isSubmitting
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text(
                      'Create',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Example: May 21, 2020
    return "${_monthString(date.month)} ${date.day.toString().padLeft(2, '0')}, ${date.year}";
  }

  String _monthString(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}