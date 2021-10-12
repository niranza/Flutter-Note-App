import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/contants.dart';

class BuildEditNote extends StatelessWidget {
  final Note currentNote;
  final Function(int) saveNote;

  const BuildEditNote({
    Key? key,
    required this.currentNote,
    required this.saveNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    titleController.text = currentNote.title;
    contentController.text = currentNote.content;

    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.grey[900], fontSize: 30),
              controller: titleController,
              onChanged: (newTitle) {
                currentNote.title = newTitle;
                saveNote(saveDelayInSeconds);
              },
              maxLength: 40,
              decoration: InputDecoration(
                hintText: "Title",
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.grey[850], fontSize: 17),
              controller: contentController,
              onChanged: (newContent) {
                currentNote.content = newContent;
                saveNote(saveDelayInSeconds);
              },
              maxLength: 30000,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 1000,
              decoration: InputDecoration(
                hintText: "Content",
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
