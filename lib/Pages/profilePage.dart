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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var _token = null;
  var _username = null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(this._username)
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