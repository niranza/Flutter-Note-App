import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Note {
  late String title;
  late String content;
  late String formattedDate;
  late int color;
  late String id;

  Note(
    this.title,
    this.content,
    String? formattedDate,
    int? color,
    String? id,
  ) {
    this.id = id ?? const Uuid().v1();
    this.color = color ?? Colors.blue[500].hashCode;
    this.formattedDate = formattedDate ?? "";
  }

  Note.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        content = json["content"],
        formattedDate = json["formatted_date"],
        color = json["color"],
        id = json["id"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "formatted_date": formattedDate,
      "color": color,
      "id": id,
    };
  }
}
