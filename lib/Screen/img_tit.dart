import 'package:flutter/material.dart';
import 'package:news_/Screen/news_p_v.dart';
import 'package:news_api_flutter_package/model/article.dart';

class Imag_tit extends StatelessWidget {
  final Article article;
  const Imag_tit({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsWepView(url: article.url!)));
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(children: [
            SizedBox(
              width: 100,
              height: 80,
              child: Image.network(article.urlToImage ?? "", fit: BoxFit.fill,
                  errorBuilder: (BuildContext, Object, StackTrace) {
                return const Icon(Icons.image_not_supported);
              }),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title!,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(article.source.name!,
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}
