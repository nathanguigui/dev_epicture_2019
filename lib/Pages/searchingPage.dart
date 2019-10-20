import 'package:epicture/Widget/ImagePreviewer.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class SearchingPage extends StatefulWidget {
  @override
  _SearchingPagePageState createState() => _SearchingPagePageState();
}

class _SearchingPagePageState extends State<SearchingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            ),
            ImagePreviewer(url: "toto", name: "toto")
          ],
        ),
      ),
    );
  }
}