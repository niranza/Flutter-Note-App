import 'dart:convert';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NoteStorage {
  static Future<String> _getNotesPath(String fileName) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath =
        fileName.isEmpty ? "$appDocumentsPath" : "$appDocumentsPath/$fileName";

    return filePath;
  }

  static void saveNote(Note note) async {
    var formatter = DateFormat("yyyy.MM.dd, HH:mm:ss");
    note.formattedDate = formatter.format(DateTime.now());
    File file = File(await _getNotesPath("${note.id}.txt"));
    file.writeAsString(jsonEncode(note));
    print("Note saved -> ${note.title}");
  }

  static Future<List<Note>> getAllNotes() async {
    String path = await _getNotesPath("");
    var jsonNotes = io.Directory(path).listSync().map((e) async {
      if (e.path.endsWith("txt")) {
        File file = File(e.path);
        return await file.readAsString().then((value) => value);
      }
    });
    List<Note> noteList = [];
    for (final futureString in jsonNotes) {
      await futureString.then((value) {
        if (value != null) {
          Map data = jsonDecode(value);
          print("noteDate-> ${data["formatted_date"] as String}");
          noteList.add(Note(
            data["title"] as String,
            data["content"] as String,
            data["formatted_date"] as String,
            data["color"] as int,
            data["id"] as String,
          ));
        }
      });
    }
    return noteList;
  }

  static Future<void> deleteNote(Note note) async {
    final file = File(await _getNotesPath("${note.id}.txt"));
    await file.delete();
  }
}
