import 'package:flutter/material.dart';
import 'package:flutter_edusn/constants/WidgetBig/chatBoxes.dart';

import 'package:flutter_edusn/model/messages_model.dart';
import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatPage extends StatefulWidget {
  ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<XFile>? _imageList;

  Future<void> attachImage() async {
    try {
      final List<XFile>? images = await ImagePicker().pickMultiImage();
      setState(() {
        _imageList = images;
        print("image added successfully");
      });
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void _clearImage() {
    setState(() {
      _imageList = null;
      isEmpty = messageController.text.trim().isEmpty;
    });
  }

  DateTime now = new DateTime.now();
  // String? minsago = Jiffy.now().fromNow();
  bool? _isLongPressActivated = true;

  TextEditingController messageController = TextEditingController();
  bool isEmpty = true;
  bool? switchIsOn = true;
  List<Message> messages = [];
  void sendMessage() {
    String text = messageController.text.trim();
    if (text.isNotEmpty || (_imageList != null && _imageList!.isNotEmpty)) {
      List<File>? images =
          _imageList?.map((xfile) => File(xfile.path)).toList();
      Message newMessage = Message(
          text: text,
          isMe: true,
          timestamp: DateTime.now(),
          ready: false,
          images: images);
      setState(() {
        messages.add(newMessage);
        print("added message");
      });

      messageController.clear();
      _clearImage();

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

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  // bool ready = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Column(children: [
          Container(
            color: const Color(0xFFF5F5F5),
            padding: const EdgeInsets.all(20.0),
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
                const Spacer(),
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
                      GestureDetector(
                          child: Chatboxes(
                            images: message.images,
                            sent: true,
                            text: message.text,
                            crdt: message.timestamp.toString(),
                            isMe: message.isMe,
                          ),
                          onLongPress: () {
                            setState(() {
                              _isLongPressActivated = true;
                              print("long press activated");
                            });
                          }),
                      if (message.isMe && !message.ready)
                        const CircularProgressIndicator(),
                      if (message.isMe && message.ready) botTest(),
                    ],
                  ),
              ],
            ),
          )),
          ChatInput()
        ])));
  }

  Widget ChatInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: attachImage,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: const Color(0xFFD9D9D9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  if (_imageList != null)
                    ..._imageList!.map((image) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                              child: Image(
                            image: AssetImage(image.path),
                            fit: BoxFit.fill,
                          )),
                        )),
                  TextField(
                    controller: messageController,
                    onChanged: (value) {
                      setState(() {
                        isEmpty = value.isEmpty && _imageList == null;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Write something...",
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: isEmpty ? Icon(Icons.mic) : Icon(Icons.send),
            onPressed: isEmpty ? () {} : sendMessage,
          ),
        ],
      ),
    );
  }

  Widget botTest() {
    return Chatboxes(
        text:
            "Hello mate!Im EDUBOT Nice to meeet you! Wait for a moment to get the reply from our customer service",
        crdt: DateTime.now().toString(),
        sent: true,
        isMe: false);
  }
}
