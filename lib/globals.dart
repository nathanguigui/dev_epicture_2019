library epicture.globals;
import 'dart:async';

import 'package:imgur/imgur.dart';


bool isLoggedIn = false;
String token = "";
String refreshToken = "";
int accountId;
String username = "";
Imgur client;