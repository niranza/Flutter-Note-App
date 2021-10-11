import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class ItemNote extends StatelessWidget {
  Note note;

  ItemNote({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(
          Icons.circle,
          size: 50,
          color: Color(note.color),
        ),
        title: Text(
          note.title,
          style: TextStyle(
            fontSize: 35,
            color: Colors.grey[900],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          note.content,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
