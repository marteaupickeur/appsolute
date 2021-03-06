import 'package:appsolute/utils/favorite.dart';
import 'package:appsolute/view_models/article_view_models.dart';
import 'package:appsolute/views/favorite.dart';
import 'package:appsolute/widget_utils/details.dart';
import 'package:appsolute/views/everything.dart';
import 'package:appsolute/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ArticleViewModel>(
          create: (_) => ArticleViewModel()),
      ChangeNotifierProvider<FavoriteArticle>(create: (_) => FavoriteArticle()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const Splash(),
        '/everything': (context) => const Everything(),
        '/details': (context) => const Details(),
        '/favorite': (context) => const Favorite()
      },
    ),
  ));
}
