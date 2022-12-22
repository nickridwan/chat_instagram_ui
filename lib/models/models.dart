import 'dart:convert';
import "package:http/http.dart" as http;

class UserModel {
  int id;
  String username;
  String email;
  String avatar;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['first_name'] + " " + json['last_name'],
        email: json['email'],
        avatar: json['avatar'],
      );

  static Future<List<UserModel>> getDataUser() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/usersfire?page=2'));
    final jsonObject = jsonDecode(response.body);
    List<dynamic> list = (jsonObject as Map<String, dynamic>)['data'];
    List<UserModel> users = [];
    for (var i = 0; i < list.length; i++) {
      users.add(UserModel.fromJson(list[i]));
    }
    return users;
  }
}
