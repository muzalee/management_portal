import 'package:flutter/material.dart';

class MenuNotifier extends ChangeNotifier {
  late GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu(GlobalKey<ScaffoldState> key) {
    final GlobalKey<ScaffoldState> scaffoldKey = key;

    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}