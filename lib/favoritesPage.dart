import 'package:flutter/material.dart';
import 'main.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Choice _selectedChoice = choices[0];
  String iconChoosen = '';

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
      iconChoosen = choice.title;
    });
  }
  @override
  Widget build(BuildContext context) {
    var listView = new ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0)
          return (Text('$iconChoosen', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),));
        else
          return new ListTile(
            leading:SizedBox(
              height: 100.0,
              width: 100.0,
              child: Image.network('https://i.imgur.com/KMLeXgi.jpg'),
           ),
           title: Text('UserName'),
         );
      },
    );
    return Scaffold(
      appBar: AppBar(title: Text("Page des favoris" ), centerTitle: true),
      body: listView,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.new_releases), onPressed: () {
                _select(choices[0]);
              },
            ),
            IconButton(icon: Icon(Icons.audiotrack), onPressed: () {
              _select(choices[1]);
            },),
            IconButton(icon: Icon(Icons.nature), onPressed: () {
              _select(choices[2]);
            },),
            IconButton(icon: Icon(Icons.beach_access), onPressed: () {
              _select(choices[3]);
            },),
            IconButton(icon: Icon(Icons.casino), onPressed: () {
              _select(choices[4]);
            },),
            IconButton(icon: Icon(Icons.child_care), onPressed: () {
              _select(choices[5]);
            },),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'New'),
  const Choice(title: 'Music'),
  const Choice(title: 'Nature'),
  const Choice(title: 'Beach'),
  const Choice(title: 'Games'),
  const Choice(title: 'Children'),
];