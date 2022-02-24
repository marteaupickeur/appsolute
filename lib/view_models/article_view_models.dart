import 'dart:io';

import 'package:appsolute/models/article.dart';
import 'package:appsolute/services/database.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  List<Article> list = [];
  String error = '';
  bool isOk = false;

  // store on articles from country on my List
  getArticlesFromCountryOnList(String country) async {
    var response = await DatabaseService().getArticlesFromCountry(country);
    handleRequest(response);
  }

  // store on articles when search on my List
  getSearchResponseOnList(
      String keyword, String language, String sortBy) async {
    var response =
        await DatabaseService().searchArticles(keyword, language, sortBy);
    handleRequest(response);
  }

  // the response handler
  handleRequest(response) {
    if (response is Response) {
      if (response.statusCode == 200) {
        // request is ok
        isOk = true;
        // On that stage we have 2 cases
        // case 1 when list = [] and error = '' => here display No articles to show
        // case 2 when list = [articles] and error = '' => here display the list of articles
        list = convertListJsonToListArticle(response.data['articles']);
        error = '';
        notifyListeners();
      }
    } else {
      // request is bad
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

  // function: convert list of json to list on article
  List<Article> convertListJsonToListArticle(List list) {
    List<Article> la = [];
    for (var l in list) {
      la.add(Article.fromJson(l));
    }
    return la;
  }
}
