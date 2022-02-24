import 'package:appsolute/models/article.dart';
import 'package:appsolute/utils/favorite.dart';
import 'package:appsolute/utils/launcher_url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/date_time_parser.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // the current article
  var article;

  // when add or remove favorite
  bool onFavorite = false;

  // the location
  // false when we came from home
  // true when its on favorite and lets pop the context and define the icon
  var inFavorite;

  @override
  Widget build(BuildContext context) {
    // recovery arguments: here the current article
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // article assignement
    if (arguments != null) {
      article = arguments['article'] as Article;
      if (arguments['where'] == 'favorite') {
        inFavorite = true;
      } else {
        inFavorite = false;
      }
    }

    // my FavoriteArticle provider
    final fa = Provider.of<FavoriteArticle>(context);

    // this boolean set favorite iconS
    if (fa.findArticleByTitle(article)) {
      onFavorite = true;
    } else {
      onFavorite = false;
    }

    return SafeArea(
      child: Scaffold(
        // color: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  (article.urlToImage == null)
                      ? Image.asset('assets/news.png')
                      : Image.network(article.urlToImage),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white60),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          )),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: (article.title == null)
                                  ? const Text('No Title')
                                  : Text(
                                      article.title,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )),
                          Column(
                            children: [
                              inFavorite
                                  ? IconButton(
                                      onPressed: () {
                                        Provider.of<FavoriteArticle>(context,
                                                listen: false)
                                            .removeArticleByTitle(article);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.delete))
                                  : onFavorite
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              onFavorite = !onFavorite;
                                              Provider.of<FavoriteArticle>(
                                                      context,
                                                      listen: false)
                                                  .removeArticleByTitle(
                                                      article);
                                            });
                                          },
                                          icon: const Icon(Icons.favorite))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              onFavorite = !onFavorite;
                                              Provider.of<FavoriteArticle>(
                                                      context,
                                                      listen: false)
                                                  .favorites
                                                  .add(article);
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.favorite_border)),
                              IconButton(
                                  onPressed: () async {
                                    if (article.url != null) {
                                      await launcher(article.url, context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('No link to reach !'),
                                      ));
                                    }
                                  },
                                  icon: const Icon(Icons.newspaper)),
                              IconButton(
                                  onPressed: () {
                                    if (article.url != null) {
                                      Share.share(article.url);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('No Link to share'),
                                      ));
                                    }
                                  },
                                  icon: const Icon(Icons.share)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: (article.source == null)
                                  ? const Text('No source')
                                  : Text("From : ${article.source['name']}")),
                          (article.publishedAt == null)
                              ? const Text('No date and time')
                              : Text(dtParser(article.publishedAt)),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      (article.description == null)
                          ? 'No description'
                          : article.description,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const Divider(),
                    const Text(
                      'Content',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      (article.content == null)
                          ? 'No content'
                          : article.content,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
