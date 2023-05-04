import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void getFields() {
    Navigator.pop(context, {
      'title': titleController.text,
      'description': descriptionController.text,
    });
  }

  void addOrEdit() {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    if (data['isEdit']) {
      titleController.text = data['title'];
      descriptionController.text = data['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    addOrEdit();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
              backgroundColor: Colors.black54, title: const Text('Note App')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Заголовок',
                    filled: true,
                    fillColor: Color.fromARGB(221, 109, 102, 102),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Описание',
                      filled: true,
                      fillColor: Color.fromARGB(221, 109, 102, 102),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(221, 109, 102, 102),
                    ),
                    onPressed: () {
                      getFields();
                    },
                    child: const Text(
                      'Ок',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
