import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class QueryListPage extends StatefulWidget {
  @override
  _QueryListPageState createState() => _QueryListPageState();
}

class _QueryListPageState extends State<QueryListPage> {
  final DatabaseReference _queryRef = FirebaseDatabase.instance.ref('queries');
  late Stream<DatabaseEvent> _queryStream;

  @override
  void initState() {
    super.initState();
    _queryStream = _queryRef.onValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Queries')),
      body: StreamBuilder<DatabaseEvent>(
        stream: _queryStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.value != null) {
              Map<dynamic, dynamic> queryMap = dataSnapshot.value as Map<dynamic, dynamic>;

              List<Map<String, dynamic>> queries = [];
              queryMap.forEach((key, value) {
                queries.add(Map<String, dynamic>.from(value));
              });

              return ListView.builder(
                itemCount: queries.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> query = queries[index];
                  return ListTile(
                    title: Text(query['query']),
                    subtitle: Text(DateTime.fromMillisecondsSinceEpoch(query['timestamp']).toString()),
                  );
                },
              );
            } else {
              return Center(child: Text('No queries found.'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
