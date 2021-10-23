import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MessageSend extends StatefulWidget {
  @override
  _MessageSendState createState() => _MessageSendState();
}

class _MessageSendState extends State<MessageSend> {
  var _enteredMessage = '';
  var _controller = new TextEditingController();
  final _db = FirebaseFirestore.instance;
  //This variable stores the image.

  //function that executes when we click button.
  void _sendMessage() async {
    _controller.clear();

    print("is empty-----${_enteredMessage.isEmpty}");
    var uname;

    await _db.collection('chat').add(
        {'text': _enteredMessage, 'time': Timestamp.now(), 'uname': uname});
    setState(() {
      _enteredMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Enter the message'),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          //This button sends message.
          IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage),
        ],
      ),
    );
  }
}
