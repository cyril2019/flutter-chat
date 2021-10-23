import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.isME, this.key, this.uname);
  final String message;
  final String uname;
  final bool isME;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isME ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: isME ? Radius.circular(10) : Radius.circular(0),
                    bottomRight:
                        isME ? Radius.circular(0) : Radius.circular(10))),
            width: 200,
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
