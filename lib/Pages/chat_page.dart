import 'package:flutter/material.dart';
import 'package:flutter_edusn/Pages/chatBoxes.dart';
import 'package:flutter_edusn/Pages/login_page.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool? switchIsOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Color(0xFFF5F5F5),
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(
                  image: AssetImage(
                    'Images/EDUSNlogop.png',
                  ),
                  height: 40,
                ),
                const Image(
                  image: AssetImage("Images/eduheadphones.png"),
                  width: 50,
                ),
                Spacer(),
                Switch(
                    value: switchIsOn!,
                    onChanged: (value) {
                      setState(() {
                        switchIsOn = value;
                      });
                    }),
                const Text("Online")
              ],
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [Chatboxes(text: "Hello", crdt: "10.22", isMe: false)],
            ),
          ),
        ],
      )),
    );
  }
}
