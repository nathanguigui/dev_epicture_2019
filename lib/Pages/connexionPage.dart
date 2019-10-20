import 'dart:io';
import 'package:epicture/Widget/LoadingCircleCenter.dart';
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

  var _token = "";
  var _openWebview = false;
  var _webviewLink = "https://api.imgur.com/oauth2/authorize?client_id=0ca03fee51c8a28&response_type=token&state=APPLICATION_STATE";
  WebviewScaffold _webviewController;
  var _username = globals.username;
  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._prefs = prefs);
        this.loadInfos();
      });
  }

  bool _checkUrl(String url) {
    if (url.substring(0, 29) == "https://pastek.space/callback")
      return true;
    return false;
  }

  void _parseUrl(String url) async {
    String infosLine = url.split("#")[1];
    UserInfos userInfos = new UserInfos();
    var infosArr = infosLine.split("&");
    var tmp;
    for (var i = 0; i < infosArr.length; i++) {
      tmp = infosArr[i].split("=");
      if (tmp[0] == "access_token") {
        userInfos.token = tmp[1];
      } if (tmp[0] == "refresh_token")
        userInfos.refreshToken = tmp[1];
      if (tmp[0] == "account_username")
        userInfos.username = tmp[1];
      if (tmp[0] == "account_id")
        userInfos.accountId = int.parse(tmp[1]);
    }
    this._prefs.setString("token", userInfos.token);
    this._prefs.setString("username", userInfos.username);
    this._prefs.setBool("authenticated", true);
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    _webviewController = WebviewScaffold(
      url: _webviewLink,
      withZoom: false,
      withLocalStorage: false,
      initialChild: Container(child: LoadingCircleCenter(),),
      appBar: new AppBar(
        title: const Text('Connexion'),
      ),
    );
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (this._checkUrl(url))
        this._parseUrl(url);
    });
    return this._webviewController;
  }

  void loadInfos() {
    setState(() {
      this._token = this._prefs.getString("token");
      this._username = this._prefs.getString("username");
    });
  }
}