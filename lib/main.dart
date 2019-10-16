import 'package:flutter/material.dart';
import 'connexionPage.dart';
import 'ourGalleryPage.dart';
import 'searchingPage.dart';
import 'addImagePage.dart';
import 'favoritesPage.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(title: 'page A'), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => AuthPage(),
      '/b': (BuildContext context) => OwnerGalleryPage(),
      '/c': (BuildContext context) => SearchingPage(),
      '/d': (BuildContext context) => AddImagePage(),
      '/e': (BuildContext context) => FavoritesPage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Epicture'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Epicture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme (
              minWidth : 220.0,
              child: RaisedButton(
                onPressed: () => Navigator.pushNamed(context, '/a'),
                child: const Text(
                    'Connexion',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme (
              minWidth : 220.0,
              child: RaisedButton(
                onPressed: () => Navigator.pushNamed(context, '/b'),
                child: const Text(
                    'Galerie Personnelle',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme (
              minWidth : 220.0,
              child: RaisedButton(
                onPressed: () => Navigator.pushNamed(context, '/c'),
                child: const Text(
                    'Chercher une image',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme (
              minWidth : 220.0,
              child: RaisedButton(
                onPressed: () => Navigator.pushNamed(context, '/d'),
                child: const Text(
                    'Ajouter une photo',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            const SizedBox(height: 30),
            ButtonTheme (
              minWidth : 220.0,
              child: RaisedButton(
                onPressed: () => Navigator.pushNamed(context, '/e'),
                child: const Text(
                    'Favoris',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
