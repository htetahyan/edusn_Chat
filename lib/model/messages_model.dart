import 'dart:io';

import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isMe;
  final DateTime? timestamp;
  final List<File>? images;
  bool ready;

  Message({
    required this.text,
    this.images,
    required this.isMe,
    required this.timestamp,
    this.ready = false,
  });
}
