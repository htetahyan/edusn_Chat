import 'package:flutter/material.dart';
import 'package:flutter_edusn/Pages/chatBoxes.dart';
import 'package:flutter_edusn/Pages/login_page.dart';
import 'package:flutter_edusn/model/messages_model.dart';
import 'dart:async';
import 'package:jiffy/jiffy.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DateTime now = new DateTime.now();
  String? minsago = Jiffy.now().fromNow();

  TextEditingController messageController = TextEditingController();

  bool? switchIsOn = true;
  List<Message> messages = [];
  void sendMessage() {
    String text = messageController.text.trim();
    if (text.isNotEmpty) {
      Message newMessage = Message(
          text: text, isMe: true, timestamp: DateTime.now(), ready: false);
      setState(() {
        messages.add(newMessage);
      });

      messageController.clear();

      // Start the timer when a message is sent
      Timer(const Duration(seconds: 1), () {
        setState(() {
          newMessage.ready = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // bool ready = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Column(children: [
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
          Expanded(
              child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                for (var message in messages)
                  Column(
                    children: [
                      Chatboxes(
                        sent: true,
                        minsago: minsago,
                        text: message.text,
                        crdt: message.timestamp.toString(),
                        isMe: message.isMe,
                      ),
                      if (message.isMe && !message.ready)
                        const CircularProgressIndicator(),
                      if (message.isMe && message.ready) botTest(),
                    ],
                  ),
              ],
            ),
          )),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.link,
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color(0xFFD9D9D9)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: "write something..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.send), onPressed: sendMessage)
                ],
              )),
        ])));
  }

  Widget botTest() {
    return Chatboxes(
        minsago: minsago,
        text: "Hello mate!Im EDUBOT Nice to meeet you!",
        crdt: DateTime.now().toString(),
        sent: true,
        isMe: false);
  }
}
