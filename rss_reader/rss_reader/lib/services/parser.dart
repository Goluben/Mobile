import 'package:rss_reader/services/news.dart';
import 'package:xml/xml_events.dart';
import 'dart:convert';
import 'dart:io';

class Parser {
  Future<List<News>> parseXml(String url) async {
    List<News> news = [];
    final req = await HttpClient().getUrl(Uri.parse(url));
    final res = await req.close();
    await res
      .transform(utf8.decoder)
      .toXmlEvents()
      .selectSubtreeEvents((value) => value.name == 'item')
      .toXmlNodes()
      .expand((element) => element)
      .forEach((element) {
        String xml = element.innerXml;
        String link = xml.substring(xml.indexOf('<link>') + '<link>'.length,  xml.indexOf('</link>'));
        String title = xml.substring(xml.indexOf('<title>') + '<![CDATA['.length + '<title>'.length, xml.indexOf('</title>') - ']]>'.length);
        String pubdate = xml.substring(xml.indexOf('<pubDate>') + '<pubDate>'.length, xml.indexOf('</pubDate>'));
        news.add(News(title: title, url: link, pubDate: pubdate));
      });
    return news;
  }
}