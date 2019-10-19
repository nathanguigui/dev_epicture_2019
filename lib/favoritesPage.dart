import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String iconChoosen = '';

  void _select(Choice choice) {
    setState(() {
      iconChoosen = choice.title;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page des favoris" ), centerTitle: true),
      body:
      SwipeList(str: '$iconChoosen'),
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

class SwipeList extends StatefulWidget {
  final String str;
  const SwipeList({Key key, this.str}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  List items = getNameList();
  List desc = getDescList();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            if (index == 0 ) {
              return Card(
                elevation: 5,
                child: Container (
                  height: 100.0,
                   child: Padding(
                    padding: EdgeInsets.fromLTRB(120, 20, 0, 0),
                      child: Text(widget.str, style: TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 48, 48, 54)
                ),),
                ),),);
            }
           return Card(
                elevation: 5,
                child: Container(
                  height: 100.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 78.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("https://i.imgur.com/KMLeXgi.jpg")
                            )
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[index],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(desc[index], style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 48, 48, 54)
                                  ),),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
          },
        ));
  }
  static List getNameList() {
    List name = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return name;
  }
  static List getDescList() {
    List desc = List.generate(10, (i) {
      return "random desc n°${i + 1}";
    });
    return desc;
  }
}