import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QueryPostPage extends StatefulWidget {
  const QueryPostPage({super.key});

  @override
  _QueryPostPageState createState() => _QueryPostPageState();
}

class _QueryPostPageState extends State<QueryPostPage> {
  final TextEditingController _queryController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _postQuery() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('queries').add({
          'userId': user.uid,
          'query': _queryController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Query posted successfully!')),
        );
        _queryController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
      }
    } catch (e) {
      print('Failed to post query: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post query: $e')),
      );
    }
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
              controller: _queryController,
              decoration: const InputDecoration(
                labelText: 'Enter your query',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _postQuery,
              child: const Text('Post Query'),
            ),
          ],
        ),
      ),
    );
  }
}
