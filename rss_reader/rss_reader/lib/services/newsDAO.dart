import './news.dart';
import './parser.dart';

class NewsDAO {
   Future<List<News>> getNewsList(String url) async {
    Parser xmlParser = Parser();
    List<News> inNews = await xmlParser.parseXml(url);
    return inNews;
  }
}