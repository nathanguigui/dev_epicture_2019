import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:imgur/imgur.dart';
import '../main.dart';
import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/globals.dart' as globals;

class UserInfos {
  int accountId;
  String username;
  String refreshToken;
  String token;
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  var _token = globals.token;
  var _openWebview = false;
  var _webviewLink = "https://api.imgur.com/oauth2/authorize?client_id=0ca03fee51c8a28&response_type=token&state=APPLICATION_STATE";
  WebviewScaffold _webviewController;
  var _username = globals.username;

  void _login() async {
    setState(() {
      _openWebview = true;
    });
  }

  bool _checkUrl(String url) {
    if (url.substring(0, 29) == "https://pastek.space/callback")
      return true;
    return false;
  }

  UserInfos _parseUrl(String url) {
    String infosLine = url.split("#")[1];
    UserInfos userInfos = new UserInfos();
    var infosArr = infosLine.split("&");
    for (var i = 1; i < infosArr.length; i++) {
      if (infosArr[i].split("=")[0] == "access_token")
        userInfos.token = infosArr[i].split("=")[1];
      if (infosArr[i].split("=")[0] == "refresh_token")
        userInfos.refreshToken = infosArr[i].split("=")[1];
      if (infosArr[i].split("=")[0] == "account_username")
        userInfos.username = infosArr[i].split("=")[1];
      if (infosArr[i].split("=")[0] == "account_id")
        userInfos.accountId = int.parse(infosArr[i].split("=")[1]);
    }
    return userInfos;
  }

  void setLogin(String token, String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("username", username);
    sharedPreferences.setBool("authenticated", true);
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
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (this._checkUrl(url)) {
        UserInfos infos = this._parseUrl(url);
        globals.token = infos.token;
        globals.accountId = infos.accountId;
        globals.username = infos.username;
        globals.refreshToken = infos.refreshToken;
        globals.isLoggedIn = true;
        this.setLogin(infos.token, infos.username);
        setState(() {
          _token = url;
          _username = infos.username;
        });
      }
      //globals.client = Imgur(Authentication.fromToken());
    });
    if (this._token is String && this._token.length != 0) {
      return Scaffold(
        appBar: AppBar(title: Text("Profil")),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(globals.username)
              ],
            )
          ],
        ),
      );
    }
    if (this._openWebview)
      return this._webviewController;
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