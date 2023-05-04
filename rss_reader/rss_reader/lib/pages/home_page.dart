import 'package:flutter/material.dart';
import '../services/news.dart';
import '../services/newsDAO.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.newsDAO});
  final NewsDAO newsDAO;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> news = [];
  String inUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('News Reader'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Read url',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Enter url'),
                      content: TextField(
                        decoration: InputDecoration(hintText: 'Url'),
                        onChanged: (String value) {
                          inUrl = value;
                        },
                      ),
                      actions: [
                        FloatingActionButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var temp = await widget.newsDAO.getNewsList(inUrl);
                            setState(() {
                              news = temp;
                            });
                          },
                          child: Text('Ok'),
                        )
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  tileColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'view', arguments: {
                      'url': news[index].url,
                    });
                  },
                  title: Text(news[index].title,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70)),
                  subtitle: Text(
                    news[index].pubDate,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,)),
              ));
        },
      ),
    );
  }
}
