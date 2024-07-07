import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_edusn/constants/sizes.dart';

class Chatboxes extends StatelessWidget {
  final String text;

  final bool isMe;
  String crdt;
  final bool sent;

  final bool edited;

  String? minsago;

  Chatboxes(
      {super.key,
      required this.text,
      required this.crdt,
      required this.sent,
      this.edited = false,
      required this.minsago,
      required this.isMe});
  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (!isMe) {
      avatar = Image.asset(
        "Images/eduheadphones.png",
        width: 40,
        height: 40,
      );
    } else {
      avatar = const CircleAvatar(
        backgroundColor: Color(0xFFE8E8E8),
        child: Text(
          "YOU",
          style: TextStyle(color: Color(0xFF7F265B)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17.0),
      child: Column(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Text(crdt),
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMe) avatar,
                const SizedBox(width: 8),
                Flexible(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isMe ? 30.0 : 0),
                      topRight: Radius.circular(isMe ? 0 : 30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: isMe
                        ? const Color(0xFFE8E8E8)
                        : const Color(0xFF183861),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: isMe ? Colors.black : Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (isMe) avatar,
              ],
            ),
            Padding(
              padding: (isMe
                  ? const EdgeInsets.only(right: 58.0)
                  : const EdgeInsets.only(right: 30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  messageInfo(
                    text: minsago.toString(),
                    icon: Icons.access_time,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  isMe
                      ? messageInfo(
                          text: (sent == true) ? 'sent' : "sending...",
                          icon: Icons.check_circle
                          // (sent == true) ?Icons.check_circle :  Icon(CupertinoIcons.circle),
                          )
                      : const Text(''),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.more_horiz_outlined),
                    onTap: () {
                      print("ouch!");
                    },
                  )
                ],
              ),
            )
          ]),
    );
  }
}

class messageInfo extends StatelessWidget {
  messageInfo({
    super.key,
    this.text = '',
    this.icon,
  });
  IconData? icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            icon,
            size: kmessageInfoIconSize,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: kmessageInfoTextSize),
          )
        ],
      ),
    );
  }
}
