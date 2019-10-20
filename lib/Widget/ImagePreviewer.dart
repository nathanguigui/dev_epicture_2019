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
    print(widget.url);
    return GestureDetector(
      onTap: () {print("todo");},
      child: Container(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Align(
            child: Row(
              children: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      child: Text(widget.name, style: TextStyle(fontSize: 20, color: Colors.green)),
                      onPressed: () {print("todo");},
                    )
                  ],
                ),
              ]
            ),
            alignment: Alignment.bottomLeft,
          )
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[900],
            image: DecorationImage(
                image: new NetworkImage(widget.url),
                fit: BoxFit.cover
            )
        ),
        height: 190.0,
        width: MediaQuery.of(context).size.width - 70.0,
        margin: EdgeInsets.only(bottom: 20),
      )
    );
  }
}