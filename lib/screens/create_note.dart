import 'package:flutter/material.dart';
import '../models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({
    super.key,
    required this.onNewNoteCreated,
  });

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Added form key for validation

  @override
  void dispose() {
    // Properly dispose controllers to prevent memory leaks
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        actions: [
          // Added save button in app bar for better UX
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Form(
        key: _formKey, // Added form for validation
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Increased padding
          child: SingleChildScrollView(
            // Added scroll for long content
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold, // Added bold for title
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    // Added validation
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  maxLines: null, // Allows multiple lines if needed
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5, // Better line spacing
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Start writing...", // More descriptive hint
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: null, // Allows infinite lines
                  keyboardType: TextInputType.multiline, // Better keyboard
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        // ignore: sort_child_properties_last
        child: const Icon(Icons.save),
        tooltip: 'Save Note', // Added tooltip for accessibility
      ),
    );
  }

  // Extracted save logic to separate method
  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      // Validate form
      final note = Note(
        title: titleController.text,
        body: bodyController.text,
        createdAt: DateTime.now(), // Assuming your model has createdAt
      );

      widget.onNewNoteCreated(note);
      Navigator.of(context).pop();
    }
  }
}
