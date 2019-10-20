import 'package:cached_network_image/cached_network_image.dart';
import 'package:epicture/Pages/imageDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePreviewer extends StatefulWidget {
  final url;
  final name;
  final id;

  const ImagePreviewer({Key key, this.url, this.name, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImagePreviewerState();

}

class _ImagePreviewerState extends State<ImagePreviewer> {
  var _token = "";

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
  }

  @override
  void initState() {
    this.getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {print("make the add to fav func");},
      onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageDetailsPage(id: widget.id, title: widget.name,)));},
      child: Container(
        width: MediaQuery.of(context).size.width - 20.0,
        margin: EdgeInsets.only(bottom: 40),
        child: Stack(
          children: <Widget>[
            Center(
              child: new CachedNetworkImage(imageUrl: widget.url, fit: BoxFit.fill),
            )
          ],
        ),
      )
    );
  }
}