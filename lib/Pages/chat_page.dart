import 'package:flutter/material.dart';
import 'package:flutter_edusn/Providers/chat_provider.dart';
import 'package:flutter_edusn/constants/WidgetBig/chatBoxes.dart';

import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  // DateTime now = new DateTime.now();
  // String? minsago = Jiffy.now().fromNow();

  // TextEditingController messageController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   messageController.dispose(); //TODO
  //   super.dispose();
  // }

  // bool ready = false;
  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(child:
            Consumer<ChatProvider>(builder: (context, chatProvider, child) {
          return Column(children: [
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
                      value: chatProvider.switchIsOn,
                      onChanged: (value) {
                        chatProvider.switchIsOn = value;
                      }),
                  const Text("Online")
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  reverse: false,
                  controller: chatProvider.scrollController,
                  padding: EdgeInsets.all(30),
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    var message = chatProvider.messages[index];
                    return Column(
                      children: [
                        GestureDetector(
                          child: Chatboxes(
                            images: message.images,
                            sent: true,
                            text: message.text,
                            crdt: message.timestamp.toString(),
                            isMe: message.isMe,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            if (chatProvider.isBotTyping)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ChatInput()
          ]);
        })));
  }
}

class ChatInput extends StatelessWidget {
  ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.link),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: chatProvider.attachImage,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: const Color(0xFFD9D9D9),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    if (chatProvider.imageList.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: chatProvider.imageList
                              .asMap()
                              .entries
                              .map((entry) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          entry.value.path,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {}),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    TextField(
                      controller: chatProvider.messageController, //TODO
                      onChanged: (value) {
                        chatProvider.updateText(value);
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
            // (chatProvider.textIsEmpty)
            //     ? IconButton(onPressed: () {}, icon: Icon(Icons.mic))
            //     : IconButton(
            //         icon: const Icon(Icons.send),
            //         onPressed: () {
            //           (chatProvider.textIsEmpty)
            //               ? ()
            //               : chatProvider.sendMessage();
            //         },
            //       ),
            IconButton(
              icon:
                  chatProvider.textIsEmpty ? Icon(Icons.mic) : Icon(Icons.send),
              onPressed: chatProvider.textIsEmpty
                  ? () {}
                  : () => chatProvider.sendMessage(
                        chatProvider.messageController.text,
                      ),
            )
          ],
        ),
      );
    });
  }
}
