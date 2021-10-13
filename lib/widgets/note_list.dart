import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/storage/note_storage.dart';
import 'item_note.dart';

class BuildNoteList extends StatefulWidget {
  final List<Note> noteList;
  final Function(Note) onNoteClicked;

  const BuildNoteList({
    Key? key,
    required this.noteList,
    required this.onNoteClicked,
  }) : super(key: key);

  @override
  _BuildNoteListState createState() => _BuildNoteListState();
}

class _BuildNoteListState extends State<BuildNoteList> {
  late Note _lastDeletedNote;

  @override
  Widget build(BuildContext context) {
    List<Note> noteList() => widget.noteList;
    return noteList().isEmpty
        ? Center(child: Text("You have no notes."))
        : Scrollbar(
            child: Container(
              padding: EdgeInsets.all(6),
              child: ListView.builder(
                itemCount: noteList().length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(noteList()[index].id),
                    onDismissed: (direction) {
                      _lastDeletedNote = noteList()[index];
                      NoteStorage.deleteNote(_lastDeletedNote);
                      setState(() => noteList().removeAt(index));

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Note successfully deleted'),
                        duration: Duration(seconds: 2),
                        dismissDirection: DismissDirection.horizontal,
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            NoteStorage.saveNote(_lastDeletedNote);
                            noteList().add(_lastDeletedNote);
                            setState(() => noteList().sort((a, b) =>
                                b.formattedDate.compareTo(a.formattedDate)));
                          },
                        ),
                      ));
                    },
                    child: BuildItemNote(
                      note: noteList()[index],
                      onNoteClicked: widget.onNoteClicked,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
