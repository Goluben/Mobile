class News {
  String title;
  String url;
  String pubDate;

  News({required this.title, required this.url, required this.pubDate});

  @override
  String toString() {
    return '$title\n$url\n$pubDate\n';
  }
}