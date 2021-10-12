import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/storage/note_storage.dart';
import 'package:notes_app/utils/contants.dart';

class AddEditNote extends StatefulWidget {
  final Object? currentNote;

  Note _getCurrentNote() =>
      currentNote == null ? Note("", "", null, null) : currentNote as Note;

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

class BuildEditNote extends StatefulWidget {
  final Note currentNote;
  final Function(int) saveNote;

  const BuildEditNote({
    Key? key,
    required this.currentNote,
    required this.saveNote,
  }) : super(key: key);

  @override
  State<BuildEditNote> createState() => _BuildEditNoteState();
}

class _BuildEditNoteState extends State<BuildEditNote> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.currentNote.title;
    contentController.text = widget.currentNote.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onChanged: (newTitle) {
                widget.currentNote.title = newTitle;
                widget.saveNote(saveDelayInSeconds);
              },
              maxLength: 40,
              decoration: InputDecoration(
                hintText: "Title",
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: contentController,
              onChanged: (newContent) {
                widget.currentNote.content = newContent;
                widget.saveNote(saveDelayInSeconds);
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
