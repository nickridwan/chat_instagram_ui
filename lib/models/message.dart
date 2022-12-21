class Message {
  int id;
  String msg;
  int type;
  DateTime date;

  Message({
    required this.id,
    required this.msg,
    required this.type,
    required this.date,
  });
}

List<Message> message = [];
