import 'package:flutter/material.dart';
import 'package:news_/Screen/img_tit.dart';
import 'package:news_api_flutter_package/model/article.dart';

class News_viwe extends StatelessWidget {
  final List<Article> article;

  const News_viwe({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        Article articlel = article[i];
        return Imag_tit(
          article: articlel,
        );
      },
      itemCount: article.length,
    );
  }
}
