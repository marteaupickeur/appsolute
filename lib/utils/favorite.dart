import 'package:appsolute/models/article.dart';
import 'package:flutter/material.dart';

class FavoriteArticle extends ChangeNotifier {
  List<Article> favorites = [];

  bool findArticleByTitle(Article article) {
    if (favorites.isEmpty) {
      return false;
    } else {
      for (Article f in favorites) {
        if (f.title == article.title) {
          return true;
        }
      }
      return false;
    }
  }

  removeArticleByTitle(Article article) {
    bool found = false;
    for (Article f in favorites) {
      if (f.title == article.title) {
        found = true;
      }
    }
    if (found) {
      favorites.remove(article);
    }
    notifyListeners();
  }
}
