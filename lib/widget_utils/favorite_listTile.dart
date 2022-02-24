import 'package:appsolute/models/article.dart';
import 'package:appsolute/utils/favorite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteListTile extends StatefulWidget {
  // wait for a favorite article to display
  final Article article;
  const FavoriteListTile({Key? key, required this.article}) : super(key: key);

  @override
  _FavoriteListTileState createState() => _FavoriteListTileState();
}

class _FavoriteListTileState extends State<FavoriteListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/details',
                arguments: {'article': widget.article, 'where': 'favorite'});
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
            trailing: IconButton(
              onPressed: () {
                Provider.of<FavoriteArticle>(context, listen: false)
                    .removeArticleByTitle(widget.article);
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
