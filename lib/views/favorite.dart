import 'dart:io';

import 'package:appsolute/utils/favorite.dart';
import 'package:appsolute/widget_utils/favoriteListTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final fa = Provider.of<FavoriteArticle>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[100],
          title: Row(
            children: const [
              Text(
                'Favorite',
                style: TextStyle(color: Colors.black),
              ),
              Icon(Icons.favorite)
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Builder(builder: (context) {
            if (fa.favorites.isNotEmpty) {
              return ListView.builder(
                  itemCount: fa.favorites.length,
                  itemBuilder: (context, i) {
                    return FavoriteListTile(article: fa.favorites[i]);
                  });
            }
            return const Center(
              child: Text('No favorites available !'),
            );
          }),
        ),
      ),
    );
  }
}
