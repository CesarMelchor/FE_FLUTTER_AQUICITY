import 'dart:convert';
import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class DataAdPage extends StatefulWidget {
  const DataAdPage({super.key});

  @override
  State<DataAdPage> createState() => _DataAdPageState();
}

class _DataAdPageState extends State<DataAdPage> {
  TextEditingController nombre = TextEditingController(text: "");
  TextEditingController link = TextEditingController(text: "");
  TextEditingController estado = TextEditingController(text: "");
  TextEditingController municipio = TextEditingController(text: "");
  TextEditingController localidad = TextEditingController(text: "");
  TextEditingController direccion = TextEditingController(text: "");
  TextEditingController referencia = TextEditingController(text: "");
  TextEditingController colonia = TextEditingController(text: "");
  TextEditingController cp = TextEditingController(text: "");
  TextEditingController telefono = TextEditingController(text: "");
  TextEditingController alternativo = TextEditingController(text: "");
  TextEditingController correoContacto = TextEditingController(text: "");
  TextEditingController sitioweb = TextEditingController(text: "");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var idsend = cookie.get('id');
  late Response response;
  late Response responseNegocio;
  Dio dio = Dio();

  Future<bool> obtainDataNegocio(BuildContext context) async {
    responseNegocio =
        await dio.get('https://aqui.city/api/public/v1/users/detail/$idsend');

    nombre.text = responseNegocio.data['name'];

    if (responseNegocio.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future obtainDataAd(BuildContext context) async {
    if (await obtainDataNegocio(context)) {
      response =
          await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

      link.text = response.data[0]['link'];
      estado.text = response.data[0]['estado'];
      municipio.text = response.data[0]['municipio'];
      localidad.text = response.data[0]['localidad'];
      direccion.text = response.data[0]['direccion'];
      referencia.text = response.data[0]['referencia'];
      colonia.text = response.data[0]['colonia'];
      cp.text = response.data[0]['cp'];
      telefono.text = response.data[0]['telefono'];
      alternativo.text = response.data[0]['telefono2'];
      correoContacto.text = response.data[0]['email'];
      sitioweb.text = response.data[0]['sitioweb'];

      return response.data;
    }

    return false;
  }

  late final Future myFuture = obtainDataAd(context);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(80),
                              child: TextFormField(
                                enabled: false,
                                controller: nombre,
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyle1("NOMBRE COMERCIAL"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(80),
                              child: TextFormField(
                                controller: link,
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyle1("LINK DEL ANUNCIO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: estado,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("ESTADO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: municipio,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("MUNICIPIO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: localidad,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("LOCALIDAD"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(3),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: direccion,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("DIRECCION"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: referencia,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("REFERENCIA"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: colonia,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("COLONIA"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(3),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: cp,
                                maxLength: 5,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("CP"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: telefono,
                                maxLength: 10,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("TELEFONO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                              child: TextFormField(
                                controller: alternativo,
                                maxLength: 10,
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyle1("NUMERO ALTERNATIVO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(3),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Adaptive.w(30),
                              child: TextFormField(
                                controller: correoContacto,
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyle1("EMAIL DE CONTACTO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(35),
                              child: TextFormField(
                                controller: sitioweb,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("SITIO WEB"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(7),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adaptive.w(25)),
                          child: OutlinedButton(
                              style: Styles.buttonAppbar,
                              onPressed: () async {
                                var dataUpdate = jsonEncode({
                                  "nombre": response.data[0]['nombre'],
                                  "link": link.text,
                                  "estado": estado.text,
                                  "municipio": municipio.text,
                                  "localidad": localidad.text,
                                  "direccion": direccion.text,
                                  "referencia": referencia.text,
                                  "colonia": colonia.text,
                                  "cp": cp.text,
                                  "telefono": telefono.text,
                                  "telefono2": alternativo.text,
                                  "email": correoContacto.text,
                                  "sitioweb": sitioweb.text,
                                });
                                if (await ApiCalls()
                                    .updateDataAd(dataUpdate, context)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Información actualizada', context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Ocurrió un error, intentalo de nuevo más tarde.',
                                      context);
                                }
                              },
                              child: const Text("Guardar datos")),
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(Adaptive.w(20)),
                  child: const CircularProgressIndicator(),
                );
        });
  }
}
