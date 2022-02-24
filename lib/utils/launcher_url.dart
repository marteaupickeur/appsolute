import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

// function : the launcher to share the url
Future launcher(String url, BuildContext ctx) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, enableJavaScript: true);
  } else {
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
      content: Text('No available url'),
    ));
  }
}
