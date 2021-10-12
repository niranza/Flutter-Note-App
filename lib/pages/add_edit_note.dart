import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/storage/note_storage.dart';
import 'package:notes_app/utils/contants.dart';
import 'package:notes_app/widgets/edit_note.dart';

class AddEditNote extends StatefulWidget {
  final Object? currentNote;

  Note _getCurrentNote() => currentNote == null
      ? Note("", "", null, null, null)
      : currentNote as Note;

  late final Note _currentNote = _getCurrentNote();

  Timer? _timer;

  AddEditNote({Key? key, required this.currentNote}) : super(key: key);

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  @override
  Widget build(BuildContext context) {
    final Note _currentNote = widget._currentNote;

    void _saveNote(int delayInSeconds) {
      widget._timer?.cancel();
      widget._timer = Timer(const Duration(seconds: saveDelayInSeconds), () {
        Note note = _currentNote;
        if (note.title.isEmpty && note.content.isEmpty) {
          NoteStorage.deleteNote(note);
        } else {
          NoteStorage.saveNote(note);
        }
      });
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);

        widget._timer?.cancel();
        Note note = _currentNote;
        if (note.title.isEmpty && note.content.isEmpty) {
          NoteStorage.deleteNote(note);
        } else {
          NoteStorage.saveNote(note);
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text("Edit Note"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: BuildEditNote(
          currentNote: _currentNote,
          saveNote: _saveNote,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text("Pick Note Color"),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: Color(_currentNote.color),
                      onColorChanged: (Color color) {
                        setState(() {
                          _currentNote.color = color.hashCode;
                          widget._timer?.cancel();
                          _saveNote(saveDelayInSeconds);
                          ;
                        });
                      },
                      showLabel: true,
                      pickerAreaHeightPercent: 0.8,
                    ),
                  )),
            );
          },
          backgroundColor: Color(_currentNote.color),
        ),
      ),
    );
  }
}
