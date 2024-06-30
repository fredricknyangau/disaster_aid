import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryPostPage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitQuery() {
    FirebaseFirestore.instance.collection('queries').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      _titleController.clear();
      _descriptionController.clear();
    }).catchError((error) {
      print('Failed to add query: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitQuery,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
