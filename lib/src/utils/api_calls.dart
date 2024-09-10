import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/providers/register_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cooky/cooky.dart' as cookie;

class ApiCalls {
  late Response response;
  late Response responseLogin;
  Dio dio = Dio();

  Future<bool> register(
      nombreF, correoF, contrasenniaF, BuildContext context) async {
    final data = {
      "name": nombreF,
      "email": correoF,
      "telefono": 0,
      "password": contrasenniaF,
      "remember_token": " "
    };

    response = await dio.post('https://aqui.city/api/public/v1/users/create',
        data: data);

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      context.read<RegisterProvider>().setId(response.data['id']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerAd(nombre, id, BuildContext context) async {
    final data = {
      "nombre": nombre,
      "link": "",
      "estado": "",
      "municipio": "",
      "localidad": "",
      "direccion": "",
      "referencia": "",
      "colonia": "",
      "cp": 0,
      "telefono": "",
      "telefono2": "",
      "email": "",
      "sitioweb": "",
      "facebook": "no",
      "twitter": "no",
      "youtube": "no",
      "instagram": "no",
      "skype": "no",
      "keywordprimary": "",
      "keywordsecondary": "",
      "descripcion": "",
      "descripcion_adicional": "",
      "logo": "0",
      "portada": "0",
      "horarios":
          "00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00<00:00",
      "comodidades": "",
      "active": 0,
      "user_id": id,
      "usuvoto": 0,
      "voto": 0,
      "banner_lateral": "0"
    };

    response =
        await dio.post('https://aqui.city/api/public/v1/ad/create', data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerMapa(id, BuildContext context) async {
    final data = {
      "linkframe": "",
      "user_id": id,
    };

    response = await dio.post('https://aqui.city/api/public/v1/mapa/create',
        data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createGalerias(id, BuildContext context) async {
    final data = {
      "linkframe": "",
      "user_id": id,
    };

    response = await dio.post('https://aqui.city/api/public/v1/mapa/create',
        data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(correoF, contrasenniaF, BuildContext context) async {
    final data = {
      "email": correoF,
      "password": contrasenniaF,
    };

    response = await dio.post('https://aqui.city/api/public/v1/users/login',
        data: data);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setId(response.data['id']);
      // ignore: use_build_context_synchronously
      cookie.set('id', Provider.of<LoginProvider>(context, listen: false).id,
          maxAge: const Duration(days: 7));
      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(response.data['mensaje']);
      return false;
    }
  }

  Future<bool> updateDataAd(dataUpdate, BuildContext context) async {
    final data = dataUpdate;
    var idsend = cookie.get('id');

    response = await dio
        .put('https://aqui.city/api/public/v1/ad/update/$idsend', data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDataAdFree(
      descripcion, telefono, ubicacion, BuildContext context) async {
    var idsend = cookie.get('id');
    FormData formData = FormData.fromMap({
      "descripcion": descripcion,
      "telefono": telefono,
      "ubicacion": ubicacion,
      "id": idsend
    });

    response = await dio.post('https://aqui.city/api/public/v1/free/update',
        data: formData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePassword(
      correo, telefono, pass, BuildContext context) async {
    FormData formData = FormData.fromMap({
      "correo": correo,
      "telefono": telefono,
      "password": pass,
    });

    response = await dio.post('https://aqui.city/api/public/v1/users/restore',
        data: formData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onCode(id, BuildContext context) async {
    response = await dio
        .put('https://aqui.city/api/public/v1/codigo/update/activate/$id');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> offCode(id, BuildContext context) async {
    response = await dio
        .put('https://aqui.city/api/public/v1/codigo/update/desactivate/$id');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDataUser(
      nombre, correo, tel, id, BuildContext context) async {
    FormData formData = FormData.fromMap(
        {"nombre": nombre, "correo": correo, "telefono": tel, "id": id});

    response = await dio.post('https://aqui.city/api/public/v1/ad/updateData',
        data: formData);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateDataMapa(dataUpdate, BuildContext context) async {
    final data = dataUpdate;
    var idsend = cookie.get('id');

    response = await dio
        .put('https://aqui.city/api/public/v1/mapa/update/$idsend', data: data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createSucursal(sucursal, BuildContext context) async {
    final data = sucursal;

    response = await dio.post('https://aqui.city/api/public/v1/sucursal/create',
        data: data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    return response.data;
  }

  Future<bool> code(code, BuildContext context) async {
    var id = cookie.get('id');
    FormData formData = FormData.fromMap({
      "id": id,
      "code": code,
    });

    response = await dio.post('https://aqui.city/api/public/v1/codigo/update',
        data: formData);

    if (response.statusCode == 200) {
      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(response.data['mensaje']);
      return false;
    }
  }
}
