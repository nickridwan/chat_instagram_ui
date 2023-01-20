import 'package:flutter/material.dart';

class MessageController with ChangeNotifier {
  String _message = "";

  String get message => _message;

  set message(v) {
    _message = v;
  }
}
