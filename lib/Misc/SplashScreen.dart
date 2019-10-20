import 'dart:async';

import 'package:epicture/Pages/connexionPage.dart';
import 'package:epicture/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences _prefs;
  var _token = null;
  var _username = null;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._prefs = prefs);
        this.loadData();
      });
  }

  Future<Timer> loadData() async {
    setState(() {
      this._token = this._prefs.getString("token");
      this._username = this._prefs.getString("username");
    });
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  void onDoneLoading() async {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    if (this._token != null && this._username != null)
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    else
      Navigator.of(context).pushNamedAndRemoveUntil('/auth', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.gif'),
          fit: BoxFit.fitHeight
        )
      )
    );
  }
}