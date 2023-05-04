import 'package:flutter/material.dart';
import 'package:note_application/impl/note_data.dart';
import 'package:note_application/services/file_system.dart';
import '../impl/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.fs});

  final FileSystem fs;

  @override
  State<HomePage> createState() => _HomePageState();
}

bool _shouldOpenTextField = false;
NoteData notesData = NoteData();
List<Note> notes = [];
List<Note> savedNotes = [];
final TextEditingController emailController = TextEditingController();

void test() {
  notesData.fillNoteList();
  notes = notesData.getNotes();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    widget.fs.readNotes().then((value) => {
          setState(() {
            savedNotes = notes = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Note App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Open search field',
            onPressed: () {
              setState(() {
                _shouldOpenTextField = !_shouldOpenTextField;
                Focus.isAt(context);
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_shouldOpenTextField)
            Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                    controller: emailController,
                    onChanged: (value) => {
                          setState(
                            () {
                              if (value == '') {
                                notes = savedNotes;
                                return;
                              }

                              notes = notesData.noteSearch(savedNotes, value);
                            },
                          )
                        },
                    decoration: InputDecoration(
                      hintText: 'Поиск заметки',
                      filled: true,
                      fillColor: Color.fromARGB(221, 109, 102, 102),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ))),
          Flexible(
              child: ListView.builder(
            itemCount: notes.length,
            padding: EdgeInsets.all(5),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    tileColor: Colors.black,
                    textColor: Colors.white,
                    title: Text(notes[index].title),
                    subtitle: Text(notes[index].description),
                    trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            notesData.deleteNote(notes, notes[index]);
                            widget.fs.writeNotes(notes);
                          });
                        }),
                    onTap: () async {
                      dynamic result = await Navigator.pushNamed(
                          context, 'add',
                          arguments: {
                            'isEdit': true,
                            'title': notes[index].title,
                            'description': notes[index].description,
                          });
                      if (result == null) {
                        return;
                      }
                      setState(() {
                        notes[index].title = result['title'];
                        notes[index].description = result['description'];
                      });

                      widget.fs.writeNotes(notes);
                    },
                  ));
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black54,
            size: 35,
          ),
          onPressed: () async {
            dynamic result = await Navigator.pushNamed(context, 'add',
                arguments: {'isEdit': false});
            if (result == null) return;
            Note newNote = Note(
                description: result['description'],
                title: result['title']);
            setState(() {
              notesData.addNote(notes, newNote);
            });

            widget.fs.writeNotes(notes);
          }),
    );
  }
}
