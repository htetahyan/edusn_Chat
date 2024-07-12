import 'dart:io';

class Message {
  final String text;
  final bool isMe;
  final DateTime? timestamp;
  final List<File>? images;
  bool ready;
  final List<String>? imageUrls;
  Message({
    required this.text,
    this.images,
    required this.isMe,
    required this.timestamp,
    this.ready = false,
    this.imageUrls,
  });
}
