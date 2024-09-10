import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _passC = true;
  bool _login = true;
  String _mensaje = "";
  String _imagenLogoDelete = "";
  String _imagenPortadaDelete = "";
  String _imagenBannerDelete = "";
  String _lastImageGalery = "";
  String _id = "";

  bool get passC => _passC;
  bool get login => _login;
  String get id => _id;
  String get mensaje => _mensaje;
  String get imagenLogoDelete => _imagenLogoDelete;
  String get imagenPortadaDelete => _imagenPortadaDelete;
  String get imagenBannerDelete => _imagenBannerDelete;
  String get lastImageGalery => _lastImageGalery;

  void setLoginCredencial() {
    _passC = !_passC;
    notifyListeners();
  }

  void setId(idR) {
    _id = idR;
    notifyListeners();
  }

  void setMesagge(idR) {
    _mensaje = idR;
    notifyListeners();
  }
   void setImageDeleteLogo(imagen) {
    _imagenLogoDelete = imagen;
    notifyListeners();
  }
   void setImageDeletePortada(imagen) {
    _imagenPortadaDelete = imagen;
    notifyListeners();
  }
   void setImageDeleteBanner(imagen) {
    _imagenBannerDelete = imagen;
    notifyListeners();
  }

  void setImageDeleteGalery(imagen) {
    _lastImageGalery = imagen;
    notifyListeners();
  }

  void setLogin() {
    _login = !_login;
    notifyListeners();
  }
}
