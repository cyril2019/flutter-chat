import 'package:chat_app/widget/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final _db = FirebaseFirestore.instance;
  var _userID;
  void getUser() async {
    _userID = await FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return StreamBuilder(
        stream: _db
            .collection('chat')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final document = snapshot.data?.docs;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              //used to display messages from bottom to top
              reverse: true,
              itemCount: document?.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                    document?[index]['text'],
                    document?[index]['uid'] == _userID,
                    ValueKey(document?[index].id),
                    document?[index]['uname']);
              });
        });
  }
}
