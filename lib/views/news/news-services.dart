import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sporto/models/news.dart';
// import 'package:news_app_api/models/article.dart';
// import 'package:news_app_api/secret.dart';

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=sports&apiKey=9a9ac82d4fac47a5ab6e37138c5b86ad";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
    for (int i = 0; i < news.length; i++) {
      print(
          '>>>>>>>>>>>>> news ::: ${news[i].title} <<<<<<<<<<<<<<<<<<<<<<<<<<');
    }
  }
}
