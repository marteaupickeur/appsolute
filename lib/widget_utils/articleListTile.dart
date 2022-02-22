import 'package:appsolute/models/article.dart';
import 'package:flutter/material.dart';

class ArticleListTile extends StatefulWidget {
  final Article article;
  const ArticleListTile({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleListTileState createState() => _ArticleListTileState();
}

class _ArticleListTileState extends State<ArticleListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/details',
                arguments: {'article': widget.article});
          },
          child: ListTile(
            leading: SizedBox(
                height: 80,
                width: 80,
                child: (widget.article.urlToImage == null)
                    ? Image.asset('assets/news.png')
                    : Image.network(widget.article.urlToImage!)),
            title: Text(widget.article.title!),
            subtitle: Text('from: ${widget.article.source["name"]}'),
          ),
        ),
        Divider()
      ],
    );
  }
}
