import 'dart:io';

import 'package:appsolute/models/article.dart';
import 'package:appsolute/services/database.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  List<Article> list = [];
  String error = '';

  getArticlesFromCountryOnList(String country) async {
    var response = await DatabaseService().getArticlesFromCountry(country);
    if (response is Response) {
      if (response.statusCode == 200) {
        // request is ok
        list = convertListJsonToListArticle(response.data['articles']);
        error = '';
        notifyListeners();
      }
    } else {
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
