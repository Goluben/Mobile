class Note {
  String title;
  String description;

  Note({required this.description, required this.title});

  Map toJson() => {
        'title': title,
        'description': description,
      };

  factory Note.fromJson(dynamic json) {
    return Note(
        title: json['title'] as String,
        description: json['description'] as String);
  }
}
