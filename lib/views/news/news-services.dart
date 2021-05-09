import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sporto/models/news.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> _news = [];

  List<Article> get news => _news;

  Future<void> getNews() async {
    _news.clear();
    notifyListeners();
    String url =
        "https://newsapi.org/v2/everything?q=sports&apiKey=9a9ac82d4fac47a5ab6e37138c5b86ad";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            source: element['source']['name'] ?? '',
            title: element['title'],
            author: element['author'],
            description: element['description'],
            imgUrl: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          _news.add(article);
        }
      });
    }
    notifyListeners();
  }
}
