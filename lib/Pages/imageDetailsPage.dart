
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epicture/Widget/LoadingCircleCenter.dart';
import 'package:flutter/material.dart';
import 'package:imgur/imgur.dart';
import 'package:imgur/imgur.dart' as ImgurApi;
import 'package:shared_preferences/shared_preferences.dart';

class ImageDetailsPage extends StatefulWidget {
  final id;
  final title;

  const ImageDetailsPage({Key key, this.id, this.title}) : super(key:key);

  @override
  State<StatefulWidget> createState() => _ImageDetailsPage();
}

class _ImageDetailsPage extends State<ImageDetailsPage> {
  var _loading = true;
  var _token = "";
  var _favorite = false;
  ImgurApi.Image _infos;

  void getInfos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    final client = Imgur(Authentication.fromToken(_token));
    final resp = await client.image.getInfos(widget.id);
    setState(() {
      _token = _token;
      _infos = resp.data;
      _loading = false;
      _favorite = resp.data.favorite;
    });
  }

  void setLike() {
    final client = Imgur(Authentication.fromToken(_token));
    client.image.favorite(widget.id).then((onValue) => {
      setState(() {
        _favorite = !_favorite;
      })
    });
  }

  @override
  void initState() {
    this.getInfos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (_loading)
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
      );
    else {
      var favIcon;
      if (_favorite)
        favIcon = Icons.favorite;
      else
        favIcon = Icons.favorite_border;
      return Scaffold(
        appBar: AppBar(title: Text(widget.title),),
        body: ListView(
          children: <Widget>[
            CachedNetworkImage(imageUrl: _infos.link, fit: BoxFit.fill,),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _infos.title == null ? "" : _infos.title,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(favIcon),
                onPressed: () {setLike();},
              )
            ],
          ),
        ),
      );
    }
  }

}