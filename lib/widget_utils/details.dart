import 'package:appsolute/models/article.dart';
import 'package:flutter/material.dart';

import '../utils/date_time_parser.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var article;
  bool onFavorite = false;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      article = arguments['article'] as Article;
    }
    return SafeArea(
      child: Material(
        color: Colors.grey[100],
        child: SingleChildScrollView(
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
                              MaterialStateProperty.all(Colors.white),
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
                                  ? Text('No Title')
                                  : Text(
                                      article.title,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )),
                          Column(
                            children: [
                              onFavorite
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          onFavorite = !onFavorite;
                                        });
                                      },
                                      icon: Icon(Icons.favorite))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          onFavorite = !onFavorite;
                                        });
                                      },
                                      icon: Icon(Icons.favorite_border)),
                              Divider(),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.share)),
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
                              ? Text('No date and time')
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
