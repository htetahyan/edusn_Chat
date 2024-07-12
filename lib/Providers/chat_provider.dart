import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_edusn/model/messages_model.dart';
import 'package:jiffy/jiffy.dart';

import 'package:image_picker/image_picker.dart';

class ChatProvider extends ChangeNotifier {
  //CHATPAGEXINPUT
  TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _switchIsOn = true;
  bool isDisposed = false;
  // bool? _isLongPressActivated = true;
  bool _textIsEmpty = true;
  List<Message> _messages = [];
  List<XFile> _imageList = [];
  bool _isBotTyping = false;
  //GETTERS
  bool get isBotTyping => _isBotTyping;
  List<Message> get messages => _messages;
  bool get switchIsOn => _switchIsOn;
  bool get textIsEmpty => _textIsEmpty;
  TextEditingController get messageController => _messageController;
  ScrollController get scrollController => _scrollController;
  List<XFile> get imageList => _imageList;

  //SETTERS
  set switchIsOn(bool value) {
    _switchIsOn = value;
    notifyListeners();
  }

  Future<void> attachImage() async {
    try {
      final List<XFile> images = await ImagePicker().pickMultiImage();

      _imageList = images;
      print("image added successfully");
      safeChangeNotifier();
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  void updateText(String text) {
    _textIsEmpty = text.isEmpty;
    notifyListeners();
  }

  // void clearImages() {
  //   _imageList = null;
  //   // isEmpty = messageController.text.trim().isEmpty; //TODO
  //   safeChangeNotifier();
  // }

  void removeImage(File image) {
    _imageList.remove(image);
    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.isNotEmpty || _imageList.isNotEmpty) {
      List<File>? images = _imageList.map((xfile) => File(xfile.path)).toList();
      Message newMessage = Message(
        text: text,
        isMe: true,
        timestamp: DateTime.now(),
        ready: false,
        images: images,
      );

      _messages.add(newMessage);
      print("User message added");

      safeChangeNotifier();
      _imageList.clear();
      _messageController.clear();
      safeChangeNotifier();

      _isBotTyping = true;
      safeChangeNotifier();

      Timer(const Duration(seconds: 1), () {
        newMessage.ready = true;
        _isBotTyping = false;
        safeChangeNotifier();

        Message botReply = Message(
          text:
              "Hello mate! I'm EDUBOT. Nice to meet you! Wait for a moment to get a reply from our customer service.",
          isMe: false,
          timestamp: DateTime.now(),
          ready: true,
        );
        _messages.add(botReply);
        print("Bot reply added");
        safeChangeNotifier();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  //CHATBOXES
  String? minsago;

  void updateTimeAgo(String? crdt) {
    minsago = Jiffy(crdt).fromNow();
    safeChangeNotifier();
  }

  void safeChangeNotifier() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    isDisposed = true;

    super.dispose();
  }
}
