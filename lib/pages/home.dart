import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/storage/note_storage.dart';
import 'package:notes_app/widgets/fab_add_note.dart';
import 'package:notes_app/widgets/note_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> _noteList = [];

  Future<dynamic> _navigateToAddEditNote() async =>
      await Navigator.pushNamed(context, "/add-edit");

  void _saveNote() =>
      NoteStorage.saveNote(Note("title", "content", null, null));

  void _getNotes() async {
    List<Note> noteList = await NoteStorage.getAllNotes();
    setState(() {
      _noteList = noteList;
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: BuildNoteList(noteList: _noteList),
      floatingActionButton: FabAddNote(
        onPressed: () async {
          dynamic result = await _navigateToAddEditNote();
          setState(() {
            _saveNote();
            _getNotes();
          });
        },
      ),
    );
  }
}

