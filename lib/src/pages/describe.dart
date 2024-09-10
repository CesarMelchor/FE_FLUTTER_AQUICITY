import 'dart:convert';

import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class DescribePage extends StatefulWidget {
  const DescribePage({super.key});

  @override
  State<DescribePage> createState() => _DescribePageState();
}

class _DescribePageState extends State<DescribePage> {
  TextEditingController descripcion = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Response response;
  Dio dio = Dio();
  late List<String> list1;
  late List<String> list2;

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    var des = response.data[0]['descripcion'];
    descripcion.text = des;

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
                  padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Adaptive.h(5),
                      ),
                      const Text(
                          "Ingresa una descripción de las actividades principales con un máximo de 120 caracteres"),
                      SizedBox(
                        height: Adaptive.h(10),
                      ),
                      SizedBox(
                        width: Adaptive.w(70),
                        child: TextFormField(
                          maxLength: 120,
                          controller: descripcion,
                          onChanged: (value) {},
                          decoration: Styles().inputStyle1("DESCRIPCIÓN"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Este campo no puede estar vacío";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Adaptive.h(10),
                      ),
                      OutlinedButton(
                          style: Styles.buttonAppbar,
                          onPressed: () async {
                            var dataUpdate = jsonEncode({
                              "descripcion": descripcion.text,
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
                          child: const Text("Guardar datos"))
                    ],
                  ),
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
