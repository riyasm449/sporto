import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/commons.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({Key key, @required this.url}) : super(key: key);
  @override
  NewsWebViewState createState() => NewsWebViewState();
}

class NewsWebViewState extends State<NewsWebView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Commons.appBar,
      body: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
