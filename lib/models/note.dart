import 'package:uuid/uuid.dart';

class Note {
  late String title;
  late String content;
  late int color;
  late String id;

  Note(this.title, this.content, int? color, String? id) {
    this.id = id ?? const Uuid().v1();
    this.color = color ?? 0xffffc107;
  }

  Note.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        content = json["content"],
        color = json["color"],
        id = json["id"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "color": color,
      "id": id,
    };
  }
}
