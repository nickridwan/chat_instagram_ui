import 'package:music_apps/controllers/dummy.dart';

class DummyUser {
  String username;
  String email;
  String password;

  DummyUser({
    required this.username,
    required this.email,
    required this.password,
  });

  factory DummyUser.fromMap(Map<String, dynamic> map) => DummyUser(
        username: map['username'],
        email: map['email'],
        password: map['password'],
      );

  static Future<List<DummyUser>> getDummy() async {
    final listObject = authLogin['data'];
    List<DummyUser> dummy = [];
    for (var i = 0; i < listObject.length; i++) {
      dummy.add(DummyUser.fromMap(listObject[i]));
    }
    return dummy;
  }
}
