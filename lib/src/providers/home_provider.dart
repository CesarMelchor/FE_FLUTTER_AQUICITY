import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String _searching = "";
  String get searching => _searching;
  void setSearching(search) {
    _searching = search;
    notifyListeners();
  }
}
