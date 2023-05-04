import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../impl/note.dart';
import 'dart:convert';

class FileSystem {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/notes_storage.json");
  }

  Future<List<Note>> readNotes() async {
    final file = await _localFile;
    final contents = await file.readAsString();
    var notes = jsonDecode(contents) as List;
    List<Note> notesList = notes.map((note) => Note.fromJson(note)).toList();
    return notesList;
  }

  Future<File> writeNotes(List<Note> notes) async {
    final file = await _localFile;
    String jsonNotes = jsonEncode(notes);
    return file.writeAsString(jsonNotes);
  }
}