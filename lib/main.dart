import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'connexionPage.dart';
import 'ourGalleryPage.dart';
import 'searchingPage.dart';
import 'addImagePage.dart';
import 'favoritesPage.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/auth': (BuildContext context) => AuthPage(),
      '/gallery': (BuildContext context) => OwnerGalleryPage(),
      '/browser': (BuildContext context) => SearchingPage(),
      '/add': (BuildContext context) => AddImagePage(),
      '/favorites': (BuildContext context) => FavoritesPage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Epicture'),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('ImgurUsr'),
                accountEmail: new Text('User@imgur.com'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://i.imgur.com/KMLeXgi.jpg'),
                ),
              ),
              ButtonTheme(
                child: FlatButton(
                  highlightColor: Colors.blue[400],
                  onPressed: () => Navigator.pushNamed(context, '/auth'),
                  child: const Text(
                      'Connexion',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 220.0,
                child: FlatButton(
                  highlightColor: Colors.blue[400],
                  onPressed: () => Navigator.pushNamed(context, '/gallery'),
                  child: const Text(
                      'Galerie Personnelle',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 220.0,
                child: FlatButton(
                  highlightColor: Colors.blue[400],
                  onPressed: () => Navigator.pushNamed(context, '/browser'),
                  child: const Text(
                      'Chercher une image',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 220.0,
                child: FlatButton(
                  highlightColor: Colors.blue[400],
                  onPressed: () => Navigator.pushNamed(context, '/add'),
                  child: const Text(
                      'Ajouter une photo',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 220.0,
                child: FlatButton(
                  highlightColor: Colors.blue[400],
                  onPressed: () => Navigator.pushNamed(context, '/favorites'),
                  child: const Text(
                      'Favoris',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      );
    }
  }