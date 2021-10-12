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

  Future<dynamic> _navigateToAddEditNote(Note? note) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return note == null
        ? await Navigator.pushNamed(context, "/add-edit")
        : await Navigator.pushNamed(context, "/add-edit", arguments: note);
  }

  void _getNotes() async {
    List<Note> noteList = await NoteStorage.getAllNotes();
    noteList.sort((a, b) => b.formattedDate.compareTo(a.formattedDate));
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
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("My Notes"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: BuildNoteList(
        noteList: _noteList,
        onNoteClicked: (Note note) async {
          await _navigateToAddEditNote(note);
          _getNotes();
        },
      ),
      floatingActionButton: FabAddNote(
        onPressed: () async {
          await _navigateToAddEditNote(null);
          _getNotes();
        },
      ),
    );
  }
}
