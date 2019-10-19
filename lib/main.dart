import 'dart:async';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'Misc/SplashScreen.dart';
import 'Pages/connexionPage.dart';
import 'Pages/ourGalleryPage.dart';
import 'Pages/searchingPage.dart';
import 'Pages/addImagePage.dart';
import 'Pages/favoritesPage.dart';
import 'Utils/globals.dart' as globals;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.yellowAccent,
      primaryColor: Colors.grey[900]
    ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/splash': (BuildContext contet) => SplashScreen(),
      '/home': (BuildContext contet) => MyHomePage(),
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
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      color: Colors.green,
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  TabController _tabController;

  var _tabPages = <Widget>[
    SearchingPage(),
    OwnerGalleryPage(),
    FavoritesPage(),
  ];

  var _tabTabs = <Tab>[
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.photo_library), text: 'Galerie'),
    Tab(icon: Icon(Icons.stars), text: 'Favoris'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabPages.length,
      vsync: this
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("EPICTURE"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {Navigator.pushNamed(context, "/auth");},
            )
          ],
        ),
        body: TabBarView(
          children: _tabPages,
          controller: _tabController,
        ),
        bottomNavigationBar: Material(
          color: Colors.grey[900],
          child: TabBar(
            tabs: _tabTabs,
            controller: _tabController,
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
          ),
        ),
      );
    }
  }