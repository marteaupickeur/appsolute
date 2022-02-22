import 'dart:io';

import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.all(10),
          child: Text('list'),
        ),
      ),
    );
  }
}
