import 'package:flutter/material.dart';

class ScaffoldService {
  static ScaffoldService i = ScaffoldService._();

  ScaffoldService._();

  GlobalKey<ScaffoldState>? _scaffoldKey;

  GlobalKey<ScaffoldState> set(GlobalKey<ScaffoldState> scaffoldKey) => _scaffoldKey = scaffoldKey;

  bool get isScaffoldSet => _scaffoldKey != null && _scaffoldKey!.currentState != null;

  bool get isDrawerOpen {
    if (!isScaffoldSet) return false;
    return _scaffoldKey!.currentState!.isDrawerOpen;
  }

  void openDrawer() {
    if (!isScaffoldSet || isDrawerOpen) return;
    _scaffoldKey!.currentState!.openDrawer();
  }
  void closeDrawer() {
    if (!isScaffoldSet || !isDrawerOpen) return;
    _scaffoldKey!.currentState!.openEndDrawer();
  }

  void toggleDrawer() {
    if (!isScaffoldSet) return;
    isDrawerOpen ? closeDrawer() : openDrawer();
  }

  bool get isEndDrawerOpen {
    if (!isScaffoldSet) return false;
    return _scaffoldKey!.currentState!.isEndDrawerOpen;
  }

  void openEndDrawer() {
    if (!isScaffoldSet || isEndDrawerOpen) return;
    _scaffoldKey!.currentState!.openEndDrawer();
  }
  void closeEndDrawer() {
    if (!isScaffoldSet || !isEndDrawerOpen) return;
    _scaffoldKey!.currentState!.openEndDrawer();
  }

  void toggleEndDrawer() {
    if (!isScaffoldSet) return;
    isEndDrawerOpen ? closeEndDrawer() : openEndDrawer();}
}
