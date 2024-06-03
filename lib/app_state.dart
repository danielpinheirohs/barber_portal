import 'package:barber_portal/core/model/barber.dart';
import 'package:barber_portal/core/model/web_user.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  static AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  static void reset() {
    _instance = AppState._internal();
  }

  WebUser? currentWebUser;
  Barber? currentBarber;
}
