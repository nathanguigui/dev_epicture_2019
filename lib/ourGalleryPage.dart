import 'package:flutter/material.dart';
import 'main.dart';

class OwnerGalleryPage extends StatefulWidget {
  @override
  _OwnerGalleryPageState createState() => _OwnerGalleryPageState();
}

class _OwnerGalleryPageState extends State<OwnerGalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Galerie")),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}