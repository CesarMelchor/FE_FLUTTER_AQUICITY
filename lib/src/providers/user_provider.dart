import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int _id = 0;

  int get id => _id;

  void setId(idResponse) {
    _id = idResponse;
    notifyListeners();
  }
  
}
