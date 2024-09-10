import 'dart:convert';

import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class WordClavePage extends StatefulWidget {
  const WordClavePage({super.key});

  @override
  State<WordClavePage> createState() => _WordClavePageState();
}

class _WordClavePageState extends State<WordClavePage> {
  TextEditingController palabra1 = TextEditingController();
  TextEditingController palabra2 = TextEditingController();
  TextEditingController palabra3 = TextEditingController();
  TextEditingController palabra4 = TextEditingController();
  TextEditingController palabra5 = TextEditingController();
  TextEditingController palabra6 = TextEditingController();
  TextEditingController palabra7 = TextEditingController();
  TextEditingController palabra8 = TextEditingController();
  var primarias = "";
  var secundarias = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Response response;
  Dio dio = Dio();
  late List<String> list1;
  late List<String> list2;

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    primarias = response.data[0]['keywordprimary'];
    secundarias = response.data[0]['keywordsecondary'];
    list1 = primarias.split("<");
    list2 = secundarias.split("<");

    palabra1.text = list1[0];
    palabra2.text = list1[1];
    palabra3.text = list1[2];
    palabra4.text = list1[3];
    palabra5.text = list2[0];
    palabra6.text = list2[1];
    palabra7.text = list2[2];
    palabra8.text = list2[3];

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PALABRAS CLAVE PRINCIPALES",
                            style: TextStyle(fontSize: Adaptive.sp(13)),
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
                                  controller: palabra1,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                                  controller: palabra2,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                            height: Adaptive.h(4),
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
                                  controller: palabra3,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                                  controller: palabra4,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: Adaptive.h(3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PALABRAS CLAVE SECUNDARIAS",
                            style: TextStyle(fontSize: Adaptive.sp(13)),
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
                                  controller: palabra5,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                                  controller: palabra6,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                            height: Adaptive.h(4),
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
                                  controller: palabra7,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                                  controller: palabra8,
                                  onChanged: (value) {},
                                  decoration:
                                      Styles().inputStyle1("PALABRA CLAVE"),
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
                                "keywordprimary":
                                    "${palabra1.text}<${palabra2.text}<${palabra3.text}<${palabra4.text}<",
                                "keywordsecondary":
                                    "${palabra5.text}<${palabra6.text}<${palabra7.text}<${palabra8.text}<",
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
