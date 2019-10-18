import 'dart:io';

import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:toast/toast.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  var _token = "";
  var _openWebview = false;
  var _webviewLink = "https://api.imgur.com/oauth2/authorize?client_id=0ca03fee51c8a28&response_type=token&state=APPLICATION_STATE";
  WebviewScaffold _webviewController;

  void _login() async {
    setState(() {
      _webviewLink: Uri.parse("https://api.imgur.com/oauth2/authorize?client_id=0ca03fee51c8a28&response_type=token&state=APPLICATION_STATE");
      _openWebview = true;
    });

    /*var result = await client.read("https://app.getpostman.com/oauth2/callback");

    new File("~/.epicture/credentials.json").writeAsString(client.credentials.toJson());
    print(client.credentials);*/
  }

  @override
  Widget build(BuildContext context) {
    _webviewController = WebviewScaffold(
      url: _webviewLink,
      withZoom: false,
      withLocalStorage: false,
      appBar: new AppBar(
        title: const Text('Connexion'),
      ),
    );
    if (this._openWebview)
      return this._webviewController;
    if (this._token.length == 0) {
      return Scaffold(
        appBar: AppBar(title: Text("Connexion")),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () => this._login(),
                child: Text("Cliquez pour vous conneter"),
              ),
            ],
          ),
        ),
      );
    }
  }
}