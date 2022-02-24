import 'package:appsolute/utils/args_conf.dart';
import 'package:dio/dio.dart';

class DatabaseService {
  ArgumentsConfiguration argsConf = ArgumentsConfiguration();
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
}
