import 'dart:io';

import 'package:flutter/material.dart';

class Message {
  int id;
  String msg;
  String picture;
  int type;
  DateTime date;

  Message({
    required this.id,
    required this.msg,
    required this.picture,
    required this.type,
    required this.date,
  });
}

List<Message> message = [];

class MessageProvider with ChangeNotifier {
  List<Message> _chat = [];

  List<Message> get chat => _chat;
  set chat(v) {
    _chat = v;
  }
}
