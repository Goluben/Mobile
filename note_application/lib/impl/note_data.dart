
import 'note.dart';

class NoteData {
  List<Note> noteList = [];

  List<Note> getNotes() {
    return noteList;
  }

  void addNote(List<Note> notes, Note note) {
    notes.add(note);
  }

  void updateNote(List<Note> notes, Note note, String newTitle, String newDescription) {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].title == note.title) {
        notes[i].title = newTitle;
        notes[i].description = newDescription;
      }
    }
  }

  void deleteNote(List<Note> notes, Note note) {
    notes.remove(note);
  }

  List<Note> noteSearch(List<Note> notes, String title) {
    List<Note> matchList = [];
    for (int i = 0; i < notes.length; i++) {
      if (notes[i].title.startsWith(title)) {
        matchList.add(notes[i]);
      }
    }

    return matchList;
  }

  void fillNoteList() {
    noteList.add(Note(description: 'hello', title: 'test1'));
    noteList.add(Note(description: 'hello', title: 'test2'));
    noteList.add(Note(description: 'hello', title: 'test3'));
  }
}
