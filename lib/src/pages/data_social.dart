import 'dart:convert';

import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class DataSocialPage extends StatefulWidget {
  const DataSocialPage({super.key});

  @override
  State<DataSocialPage> createState() => _DataSocialPageState();
}

class _DataSocialPageState extends State<DataSocialPage> {
  TextEditingController facebook = TextEditingController();
  TextEditingController twiter = TextEditingController();
  TextEditingController youtube = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController skype = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Response response;
  Dio dio = Dio();

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    facebook.text = response.data[0]['facebook'];
    twiter.text = response.data[0]['twitter'];
    youtube.text = response.data[0]['youtube'];
    instagram.text = response.data[0]['instagram'];
    skype.text = response.data[0]['skype'];

    return response.data;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          SizedBox(
                            width: Adaptive.w(35),
                            child: TextFormField(
                              controller: facebook,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("FACEBOOK"),
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
                              controller: twiter,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("TWITTER"),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          SizedBox(
                            width: Adaptive.w(35),
                            child: TextFormField(
                              controller: youtube,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("YOUTUBE"),
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
                              controller: instagram,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("INSTAGRAM"),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          SizedBox(
                            width: Adaptive.w(45),
                            child: TextFormField(
                              controller: skype,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("SKYPE"),
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
                                "facebook": facebook.text,
                                "twitter": twiter.text,
                                "youtube": youtube.text,
                                "instagram": instagram.text,
                                "skype": skype.text,
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
            : const CircularProgressIndicator();
      },
    );
  }
}
