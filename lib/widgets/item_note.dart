import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class BuildItemNote extends StatelessWidget {
  final Note note;
  final Function(Note) onNoteClicked;

  const BuildItemNote({
    Key? key,
    required this.note,
    required this.onNoteClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: ListTile(
        onTap: () => onNoteClicked(note),
        leading: Icon(
          Icons.circle,
          size: 55,
          color: Color(note.color),
        ),
        title: Text(
          note.title.isEmpty ? "no-title" : note.title,
          style: TextStyle(
            fontSize: 40,
            color: note.title.isEmpty ? Colors.grey[700] : Colors.grey[900],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          note.formattedDate,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 17,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
