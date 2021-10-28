// @dart=2.9

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Artical_view extends StatefulWidget {
  final String blogurl;

  Artical_view({this.blogurl});

  @override
  _Artical_viewState createState() => _Artical_viewState();
}

class _Artical_viewState extends State<Artical_view> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
        elevation: 0.0,
        actions: [
          Opacity(
            opacity: 0.0,
            child: Container(
                padding: (EdgeInsets.symmetric(horizontal: 16.0)),
                child: Icon(Icons.save)),
          )
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogurl,
          onWebViewCreated: ((WebViewController webviewcontroller) {
            _completer.complete(webviewcontroller);
          }),
        ),
      ),
    );
  }
}
