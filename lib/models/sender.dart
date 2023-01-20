import 'package:flutter/material.dart';

class SenderModel {
  String name;
  int type;
  String msg;
  String pict;
  String vid;

  SenderModel({
    required this.name,
    required this.type,
    required this.msg,
    required this.pict,
    required this.vid,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) => SenderModel(
        name: json[""],
        type: json[""],
        msg: json[""],
        pict: json[""],
        vid: json[""],
      );
}

class SenderProvider with ChangeNotifier {
  int _typer = 1;
  int get typer => _typer;
  set typer(v) {
    _typer = v;
  }

  void findUser(user) {
    (typer == 1) ? (user = "pengirim") : (user = "penerima");
    // ignore: void_checks
    return user;
  }
}
