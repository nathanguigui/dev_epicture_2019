import 'dart:math';

import 'package:epicture/Widget/ImagePreviewer.dart';
import 'package:epicture/Widget/LoadingCircleCenter.dart';
import 'package:flutter/material.dart';
import 'package:imgur/imgur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imgur/imgur.dart' as ImgurApi;
import '../main.dart';

class SearchingPage extends StatefulWidget {
  @override
  _SearchingPagePageState createState() => _SearchingPagePageState();
}

class _SearchingPagePageState extends State<SearchingPage> {
  var _token = "";
  List<ImgurApi.GalleryAlbumImage> _pictures;
  var _loading = true;

  void getImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    final client = Imgur(Authentication.fromToken(_token));
    final resp = await client.gallery.list(showMature: true);
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
      return LoadingCircleCenter();
    else {
      this._pictures.forEach((pic) => {
        if (pic.isAlbum) {
          pic.images.forEach((subImg) => {
            if (subImg.animated == true) {
              //picWidget.add(ImagePreviewer(url: subImg.gifv, name: subImg.title == null ? "" : subImg.title,))
            } else if (subImg.animated == false)
              picWidget.add(ImagePreviewer(url: subImg.link, name: subImg.title == null ? "" : subImg.title, id: subImg.id,))
          }),
        } else {
          if (pic.animated == true) {
            //ImagePreviewer(url: pic.gifv, name: pic.title == null ? "" : pic.title,)
          } else
            picWidget.add(ImagePreviewer(url: pic.link, name: pic.title == null ? "" : pic.title, id: pic.id,))
        }
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