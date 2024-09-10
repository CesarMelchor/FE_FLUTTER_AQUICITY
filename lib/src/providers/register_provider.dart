import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {

  int _id = 0;

  bool _passC = true;
  bool _passConfirm = true;

  bool get passC => _passC;
  bool get passConfirm => _passConfirm;
  int get id => _id;

  void setLoginCredencial() {
    _passC = !_passC;
    notifyListeners();
  }

  void setLoginCredencialConfirm() {
    _passConfirm = !_passConfirm;
    notifyListeners();
  }

  void setId(idR) {
    _id = idR;
    notifyListeners();
  }
  
}
