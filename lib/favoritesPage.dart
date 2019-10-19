import 'package:flutter/material.dart';
import 'main.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {
    var listView = new ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          leading:SizedBox(
            height: 100.0,
            width: 100.0,
            child: Image.network('https://i.imgur.com/KMLeXgi.jpg'),
          ),
          title: new Text('UserName'),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text("Page des favoris")),
      body: listView,
    );
  }
}