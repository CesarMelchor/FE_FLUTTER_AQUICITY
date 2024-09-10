import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class DataPropertyScreen extends StatefulWidget {
  const DataPropertyScreen({super.key});

  @override
  State<DataPropertyScreen> createState() => _DataPropertyScreenState();
}

class _DataPropertyScreenState extends State<DataPropertyScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController correo = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var idsend = cookie.get('id');

  late Response response;
  Dio dio = Dio();

  Future obtainDataAd(BuildContext context) async {
    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    nombre.text = response.data[0]['nombre'];
    correo.text = response.data[0]['email'];
    telefono.text = response.data[0]['telefono'];

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
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                    title: const AppbarBusiness(),
                  ),
                  drawer: const DrawerBussiness(),
                  body: Column(
                    children: [
                      SizedBox(
                        height: Adaptive.h(5),
                      ),
                      Text(
                        "Datos del propietario",
                        style: TextStyle(fontSize: Adaptive.sp(15)),
                      ),
                      SizedBox(
                        height: Adaptive.h(10),
                      ),
                      SizedBox(
                        width: Adaptive.w(80),
                        child: TextFormField(
                          controller: nombre,
                          onChanged: (value) {},
                          decoration: Styles().inputStyle1("NOMBRE"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Este campo no puede estar vacío";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: Adaptive.h(5),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
                        child: SizedBox(
                          width: Adaptive.w(90),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Adaptive.w(30),
                                child: TextFormField(
                                  controller: correo,
                                  onChanged: (value) {},
                                  decoration: Styles().inputStyle1("CORREO"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo no puede estar vacío";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                width: Adaptive.w(30),
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Adaptive.h(15),
                      ),
                      OutlinedButton(
                          style: Styles.buttonAppbar,
                          onPressed: () async {
                            if (await ApiCalls().updateDataUser(nombre.text,
                                correo.text, telefono.text, idsend, context)) {
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
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
