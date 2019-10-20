import 'package:epicture/Widget/ImagePreviewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:imgur/imgur.dart';
import 'package:imgur/imgur.dart' as ImgurApi;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var _token = "";
  List<ImgurApi.Image> _pictures;
  var _loading = true;

  void getImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    final client = Imgur(
      Authentication.fromToken(_token));
    _token = prefs.getString("token");
    final resp = await client.account.getImages();
    setState(() {
      _token = _token;
      _pictures = resp.data;
      _loading = false;
    });
  }

  @override
  void initState() {
    this.getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> picWidget = [];
    if (_loading)
      picWidget.add(Text("Loading"));
    else {
      this._pictures.forEach((pic) => {
        if (pic.favorite)
          picWidget.add(ImagePreviewer(url: pic.link, name: pic.title,)),
      });
    }
    return Scaffold(
      appBar: null,
      body: Center(
        child: ListView(
          children: picWidget,
          padding: EdgeInsets.all(20),
        ),
      ),
    );
  }
}