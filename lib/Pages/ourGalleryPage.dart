import 'package:epicture/Widget/ImagePreviewer.dart';
import 'package:epicture/Widget/LoadingCircleCenter.dart';
import 'package:flutter/material.dart';
import 'package:imgur/imgur.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imgur/imgur.dart' as ImgurApi;
import '../main.dart';

class OwnerGalleryPage extends StatefulWidget {
  @override
  _OwnerGalleryPageState createState() => _OwnerGalleryPageState();
}

class _OwnerGalleryPageState extends State<OwnerGalleryPage> {
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
      return LoadingCircleCenter();
    else {
      this._pictures.forEach((pic) => {
        picWidget.add(ImagePreviewer(url: pic.link, name: pic.title, id: pic.id,)),
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