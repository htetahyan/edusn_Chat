import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_edusn/Providers/chat_provider.dart';
import 'package:flutter_edusn/constants/sizes.dart';

import 'package:provider/provider.dart';

class Chatboxes extends StatefulWidget {
  final String text;
  final bool isMe;
  final String crdt;
  final bool sent;
  final bool edited;
  final List<File>? images;

  Chatboxes({
    Key? key,
    required this.text,
    this.images,
    required this.crdt,
    required this.sent,
    this.edited = false,
    required this.isMe,
  }) : super(key: key);

  @override
  _ChatboxesState createState() => _ChatboxesState();
}

class _ChatboxesState extends State<Chatboxes> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTimeAgo();
      _timer = Timer.periodic(Duration(minutes: 1), (timer) {
        _updateTimeAgo();
      });
    });
  }

  void _updateTimeAgo() {
    context.read<ChatProvider>().updateTimeAgo(widget.crdt);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? minsAgo = context.watch<ChatProvider>().minsago;
    Widget avatar;
    if (!widget.isMe) {
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
      padding: const EdgeInsets.symmetric(vertical: 17),
      child: Column(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Text(widget.crdt),
            Row(
              mainAxisAlignment:
                  widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isMe) avatar,
                const SizedBox(width: 8),
                Flexible(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.isMe ? 30.0 : 0),
                      topRight: Radius.circular(widget.isMe ? 0 : 30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: widget.isMe
                        ? const Color(0xFFE8E8E8)
                        : const Color(0xFF183861),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.images != null && widget.images!.isNotEmpty)
                          Column(
                            children: widget.images!.map((image) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                  maxHeight: 350,
                                ),
                                child: Image.file(
                                  image,
                                  fit: BoxFit.fill,
                                ),
                              );
                            }).toList(),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Text(
                            textAlign: TextAlign.left,
                            widget.text,
                            style: TextStyle(
                                color:
                                    widget.isMe ? Colors.black : Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.isMe) avatar,
              ],
            ),
            Padding(
              padding: (widget.isMe
                  ? const EdgeInsets.only(right: 58.0)
                  : const EdgeInsets.only(right: 30.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  messageInfo(
                    text: minsAgo.toString(),
                    icon: Icons.access_time,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  widget.isMe
                      ? messageInfo(
                          text: (widget.sent == true) ? 'sent' : "sending...",
                          icon: Icons.check_circle,
                        )
                      : const Text(''),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.more_horiz_outlined),
                    onTap: () {
                      // print("ouch!");
                      showDialog(
                          context: (context),
                          builder: (context) => const AlertDialog(
                                elevation: 10,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MsgEditDialog(
                                        icon: Icons.edit, text: 'Edit'),
                                    Divider(),
                                    MsgEditDialog(
                                        icon: Icons.reply, text: 'Reply'),
                                    Divider(),
                                    MsgEditDialog(
                                        icon: Icons.copy, text: 'Copy'),
                                    Divider(),
                                    MsgEditDialog(
                                        icon: Icons.delete, text: 'Delete'),
                                  ],
                                ),
                              ));
                    },
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

class MsgEditDialog extends StatelessWidget {
  final String text;
  final IconData icon;

  const MsgEditDialog({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(text), Spacer(), Icon(icon)],
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
