import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/storage/note_storage.dart';
import 'item_note.dart';

class BuildNoteList extends StatefulWidget {
  List<Note> noteList;

  BuildNoteList({Key? key, required this.noteList}) : super(key: key);

  @override
  _BuildNoteListState createState() => _BuildNoteListState();
}

class _BuildNoteListState extends State<BuildNoteList> {
  @override
  Widget build(BuildContext context) {
    List<Note> noteList = widget.noteList;
    return noteList.isEmpty
        ? Center(child: Text("You have no notes."))
        : Scrollbar(
            child: Container(
              padding: EdgeInsets.all(6),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(noteList[index].id),
                    onDismissed: (direction) {
                      setState(() {
                        NoteStorage.deleteNote(noteList[index]);
                        noteList.removeAt(index);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Note successfully deleted'),
                      ));
                    },
                    child: ItemNote(
                      note: noteList[index],
                    ),
                  );
                },
                itemCount: noteList.length,
              ),
            ),
          );
  }
}
