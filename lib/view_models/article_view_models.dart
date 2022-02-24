import 'dart:io';

import 'package:appsolute/models/article.dart';
import 'package:appsolute/services/database.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  List<Article> list = [];
  String error = '';
  bool isOk = false;

  getArticlesFromCountryOnList(String country) async {
    var response = await DatabaseService().getArticlesFromCountry(country);
    if (response is Response) {
      if (response.statusCode == 200) {
        isOk = true;
        // request is ok
        // On that stage we have 2 cases
        // case 1 when list = [] and error = '' => here display No articles to show
        // case 2 when list = [articles] and error = '' => here display the list of articles
        list = convertListJsonToListArticle(response.data['articles']);
        error = '';
        notifyListeners();
      }
    } else {
      isOk = false;
      // connexion problem or APIkey problem
      if (response == 'fill an API key') {
        error = 'Put an API key!';
      } else {
        // some problem with the request or on the API
        if (response is DioError) {
          if (response.response == null) {
            error = 'Check your connection!';
          } else {
            error = response.response!.data['message'];
          }
        }
      }
      list = [];
      notifyListeners();
    }
  }

  List<Article> convertListJsonToListArticle(List list) {
    List<Article> la = [];
    for (var l in list) {
      la.add(Article.fromJson(l));
    }
    return la;
  }
}
