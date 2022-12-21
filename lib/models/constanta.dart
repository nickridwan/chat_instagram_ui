import "package:http/http.dart" as http;
import 'dart:convert';

class Constanta {
  String list;
  bool visibility;

  Constanta({
    required this.list,
    required this.visibility,
  });

  factory Constanta.fromModel(Map<String, dynamic> model) => Constanta(
        list: model['list'],
        visibility: model['visiblity'],
      );

  static Future<List<Constanta>> getConst() async {
    final response = await http.get(Uri.parse('https://ridwanhanif.my.id'));
    final jsonObject = response.body;

    List<dynamic> list = (jsonObject as Map<String, dynamic>)['result'];
    List<Constanta> name = [];
    for (var i = 0; i < list.length; i++) {
      name.add(Constanta.fromModel(list[i]));
    }
    return name;
  }
}
