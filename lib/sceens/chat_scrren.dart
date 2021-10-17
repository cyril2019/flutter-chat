import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chat/QEY4RZr8dxH5f0mz4D3T/messages')
              .add({'text': 'Added on click'});
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat/QEY4RZr8dxH5f0mz4D3T/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot snapshot) {
          final documents = snapshot.data.docs;
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              );
            },
            itemCount: documents.length,
          );
        },
      ),
    );
  }
}
