import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWepView extends StatefulWidget {
  final String url;
  NewsWepView({
    super.key,
    required this.url,
  });

  @override
  State<NewsWepView> createState() => _NewsWepViewState();
}

class _NewsWepViewState extends State<NewsWepView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appCacheEnabled: true,
      url: widget.url,
      appBar: AppBar(
        title: Text(
          "News Now",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
