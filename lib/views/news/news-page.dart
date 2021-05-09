import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sporto/views/news/web-view.dart';

import '../../utils/commons.dart';
import 'news-services.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsProvider newsProvider;
  @override
  void initState() {
    NewsProvider _newsProvider =
        Provider.of<NewsProvider>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _newsProvider.getNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newsProvider = Provider.of<NewsProvider>(context);
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: newsProvider.news?.length ?? 0,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsWebView(
                                  url: newsProvider.news[index].articleUrl,
                                )),
                      );
                    },
                    child: newsTile(
                      imgUrl: newsProvider.news[index].imgUrl,
                      title: newsProvider.news[index].title,
                      description: newsProvider.news[index].description,
                      date: newsProvider.news[index].publshedAt,
                      author: newsProvider.news[index].source,
                    ),
                  ),
                )));
  }

  Widget newsTile(
      {String imgUrl,
      String title,
      String description,
      DateTime date,
      String author}) {
    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
          ),
          Positioned(
            top: 2,
            right: 2,
            left: 2,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
              top: 155,
              right: 4,
              left: 4,
              child: Text(
                title ?? '',
                textAlign: TextAlign.justify,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
              )),
          Positioned(
              top: 195,
              right: 4,
              left: 4,
              child: Text(
                description ?? '',
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: Commons.greyAccent4,
                  fontSize: 12,
                ),
              )),
          Positioned(
              top: 145,
              right: 4,
              child: Text(
                author ?? '',
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.redAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
