import 'package:chat_app/widget/chat/message_sent.dart';
import 'package:chat_app/widget/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.menu),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [Icon(Icons.exit_to_app), Text("Logout")],
                  ),
                ),
                value: 'logout',
              )
            ],
            //this takes a function with value of item as parameter.
            onChanged: (item) {
              if (item == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: Messages()), MessageSend()],
        ),
      ),
    );
  }
}
