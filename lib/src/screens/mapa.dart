import 'dart:convert';

import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  TextEditingController mapa = TextEditingController();

  late Response response;
  Dio dio = Dio();

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response =
        await dio.get('https://aqui.city/api/public/v1/mapa/detail/$idsend');

    mapa.text = response.data[0]['linkframe'];

    return response.data;
  }

  late final Future myFuture = obtainDataAd(context);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Form(
                key: _formKey,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                    title: const AppbarBusiness(),
                  ),
                  drawer: const DrawerBussiness(),
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        Text(
                          "MAPA",
                          style: TextStyle(fontSize: Adaptive.sp(15)),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        const Divider(),
                        Text(
                          "INGRESA EL LINK DEL MAPA CARGADO",
                          style: TextStyle(fontSize: Adaptive.sp(15)),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          child: SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                              controller: mapa,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("LINK"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Este campo no puede estar vacío";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(7),
                        ),
                        OutlinedButton(
                            style: Styles.buttonAppbar,
                            onPressed: () async {
                              var dataUpdate = jsonEncode({
                                "linkframe": mapa.text,
                              });
                              if (await ApiCalls()
                                  .updateDataMapa(dataUpdate, context)) {
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
                            child: Text(
                              "Guardar datos",
                              style: TextStyle(fontSize: Adaptive.sp(12)),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
