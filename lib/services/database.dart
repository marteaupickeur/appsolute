import 'package:appsolute/utils/args_conf.dart';
import 'package:dio/dio.dart';

class DatabaseService {
  // recovery the APIkey on prompt when launch the app
  ArgumentsConfiguration argsConf = ArgumentsConfiguration();

  // get Headlines news from country
  Future getArticlesFromCountry(String country) async {
    if (argsConf.myApiKey == '') {
      return 'fill an API key';
    }

    try {
      var response = await Dio().get(
          "https://newsapi.org/v2/top-headlines?country=${country}&apiKey=${argsConf.myApiKey}");
      return response;
    } catch (e) {
      return e;
    }
  }

  // search an aricle all over around the API
  // with some parameters and then mixin it and get the response
  Future searchArticles(String keyword, String language, String sortBy) async {
    if (argsConf.myApiKey == '') {
      return 'fill an API key';
    }

    // on this var i will set the good url to search
    // by default value only search on keyword
    String url =
        "https://newsapi.org/v2/everything?q=${keyword}&pageSize=10&apiKey=${argsConf.myApiKey}";

    // only language will be set
    if (language != 'none' && sortBy == 'none') {
      url =
          "https://newsapi.org/v2/everything?q=${keyword}&language=${language}&pageSize=10&apiKey=${argsConf.myApiKey}";
    }

    // only sortBy will be set
    if (sortBy != 'none' && language == 'none') {
      url =
          "https://newsapi.org/v2/everything?q=${keyword}&sortBy=${sortBy}&pageSize=10&apiKey=${argsConf.myApiKey}";
    }

    // all parameters will be set
    if (sortBy != 'none' && language != 'none') {
      url =
          "https://newsapi.org/v2/everything?q=${keyword}&language=${language}&sortBy=${sortBy}&pageSize=10&apiKey=${argsConf.myApiKey}";
    }

    try {
      var response = await Dio().get(url);
      return response;
    } catch (e) {
      return e;
    }
  }
}
