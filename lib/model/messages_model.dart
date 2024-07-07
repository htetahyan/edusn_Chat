import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMe;
  final DateTime? timestamp;
  bool ready;

  Message({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.ready = false,
  });
}
