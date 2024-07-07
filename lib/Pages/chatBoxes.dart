import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chatboxes extends StatelessWidget {
  String? text;

  bool? isMe;
  String crdt;
  bool? sent;

  Chatboxes(
      {super.key,
      required this.text,
      required this.crdt,
      this.sent,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        CircleAvatar(
            child: (isMe == true)
                ? const Text(
                    "YOU",
                    style: TextStyle(color: Color(0xFF7F265B)),
                  )
                : const Image(
                    image: AssetImage("Images/eduheadphones.png"),
                  )),
        Material(
          elevation: 5.0,
          borderRadius: isMe!
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0))
              : BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
          color: isMe! ? Colors.lightBlue : Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              text!,
              style: TextStyle(
                  fontSize: 15.0, color: isMe! ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
