import 'dart:io';
import 'package:epicture/Widget/LoadingCircleCenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/painting.dart';
import 'package:imgur/imgur.dart';
import 'package:imgur/imgur.dart' as ImgurApi;
import 'dart:developer';
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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var _token = null;
  var _username = null;
  AccountSettings _email = null;
  AvatarData _avatar = null;
  String _urlAvatar = null;
  String _mail = null;
  bool _mature = null;
  var _loading = true;

  SharedPreferences _prefs;


  void getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    final client = Imgur(
        Authentication.fromToken(_token));
    _token = prefs.getString("token");
    final resp = await client.account.getSettings();
    final avatar = await client.account.getAvatar();
    setState(() {
      _email = resp.data;
      _mail = _email.email;
      _mature = _email.showMature;
      _avatar = avatar.data;
      _urlAvatar = _avatar.location;

      _loading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._prefs = prefs);
        this.loadInfos();
        this.getSettings();
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading)
      return LoadingCircleCenter();
    return Scaffold(
      appBar: AppBar(title: Text("Profil")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              CircleAvatar (
                radius: 100.0,
                backgroundImage: new NetworkImage(this._urlAvatar),
              ),
              const SizedBox(height: 30),
              new Container(
                width: 300.0,
                height: 20.0,
                child: Text("Nom d'utilisateur : " + this._username),
                alignment: Alignment(0.0, 0.0),
              ),
              const SizedBox(height: 30),
              new Container(
                width: 300.0,
                height: 20.0,
                child: Text("Email : " + this._mail),
                alignment: Alignment(0.0, 0.0),
              ),
            ],
          )
        ],
      ),
    );
    }

    void loadInfos() {
      setState(() {
        this._token = this._prefs.getString("token");
        this._username = this._prefs.getString("username");
      });
    }
}