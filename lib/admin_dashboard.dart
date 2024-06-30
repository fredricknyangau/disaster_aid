import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('queries').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No queries found'));
          }

          var queries = snapshot.data!.docs;

          return ListView.builder(
            itemCount: queries.length,
            itemBuilder: (context, index) {
              var query = queries[index];
              return ListTile(
                title: Text(query['title']),
                subtitle: Text(query['description']),
                onTap: () {
                  // Navigate to detailed view
                },
              );
            },
          );
        },
      ),
    );
  }
}
