import 'dart:typed_data';

import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cooky/cooky.dart' as cookie;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdminFreeScreen extends StatefulWidget {
  const AdminFreeScreen({super.key});

  @override
  State<AdminFreeScreen> createState() => _AdminFreeScreenState();
}

class _AdminFreeScreenState extends State<AdminFreeScreen> {
  TextEditingController descripcion = TextEditingController(text: "");
  TextEditingController telefono = TextEditingController(text: "");
  TextEditingController ubicacion = TextEditingController(text: "");
  TextEditingController codigo = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var idsend = cookie.get('id');
  late Response responseInformacion;
  Dio dio = Dio();

  String logodelete = "";
  String portadadelete = "";

  Uint8List? _logotipoShow;

  Uint8List? _portadaShow;

  List<PlatformFile>? _pathLogotipo;

  List<PlatformFile>? _pathPortada;

  static Future<bool> uploadFile(List<int> file, String fileName,
      BuildContext context, locate, campo) async {
    var userId = cookie.get('id');
    var dio = Dio();

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      ),
      "locate": locate,
      "id": userId,
      "campo": campo
    });
    var response = await dio.post("https://aqui.city/api/public/v1/uploadFile",
        data: formData);
    if (response.statusCode == 200) {
      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(response.data['mensaje']);
      return false;
    }
  }

  Future<bool> updateFile(List<int> file, String fileName, BuildContext context,
      locate, campo, last, opcion) async {
    var userId = cookie.get('id');
    var dio = Dio();

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      ),
      "locate": locate,
      "id": userId,
      "campo": campo,
      "lastImage": last
    });
    var response = await dio.post("https://aqui.city/api/public/v1/updateFile",
        data: formData);

    if (response.statusCode == 200) {
      if (opcion == 1) {
        logodelete = response.data['mensaje'];
      }
      if (opcion == 2) {
        portadadelete = response.data['mensaje'];
      }

      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(response.data['mensaje']);
      return false;
    }
  }

  Future obtainDataAd(BuildContext context) async {
    responseInformacion =
        await dio.get('https://aqui.city/api/public/v1/free/detail/$idsend');

    descripcion.text = responseInformacion.data[0]['descripcion'];
    telefono.text = responseInformacion.data[0]['telefono'];
    ubicacion.text = responseInformacion.data[0]['direccion'];
    logodelete = responseInformacion.data[0]['logo'];
    portadadelete = responseInformacion.data[0]['portada'];

    return responseInformacion.data;
  }

  late final Future myFuture = obtainDataAd(context);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                  title: const AppbarBusiness(),
                ),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      // datos
                      Column(
                        children: [
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          SizedBox(
                            width: Adaptive.w(80),
                            child: TextFormField(
                              controller: descripcion,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("DESCRIPCION"),
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
                          SizedBox(
                            width: Adaptive.w(80),
                            child: TextFormField(
                              controller: telefono,
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
                            height: Adaptive.h(5),
                          ),
                          SizedBox(
                            width: Adaptive.w(80),
                            child: TextFormField(
                              controller: ubicacion,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("UBICACION"),
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
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adaptive.w(25)),
                        child: OutlinedButton(
                            style: Styles.buttonAppbar,
                            onPressed: () async {
                              if (await ApiCalls().updateDataAdFree(
                                  descripcion.text,
                                  telefono.text,
                                  ubicacion.text,
                                  context)) {
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
                      ),
                      // imagenes

                      SizedBox(
                        height: Adaptive.h(5),
                      ),
                      Column(
                        children: [
                          Text(
                            "Elige tu logotipo",
                            style: TextStyle(fontSize: Adaptive.sp(15)),
                          ),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          SizedBox(
                            height: Adaptive.h(60),
                            child: _logotipoShow != null
                                ? Image.memory(_logotipoShow!)
                                : responseInformacion.data[0]['logo'] == '0'
                                    ? const ColoredBox(color: Colors.grey)
                                    : Image.network(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "https://aqui.city/api/writable/" +
                                            responseInformacion.data[0]
                                                ['logo']),
                          ),
                          SizedBox(
                            height: Adaptive.h(4),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Adaptive.w(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                    style: Styles.buttonAppbar,
                                    onPressed: () async {
                                      _pathLogotipo =
                                          (await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowMultiple: false,
                                        allowedExtensions: [
                                          'png',
                                          'jpg',
                                          'jpeg',
                                          'heic'
                                        ],
                                      ))
                                              ?.files;
                                      setState(() {
                                        if (_pathLogotipo != null) {
                                          if (_pathLogotipo != null) {
                                            //passing file bytes and file name for API call
                                            _logotipoShow =
                                                _pathLogotipo!.first.bytes!;
                                            // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                          }
                                        }
                                      });
                                    },
                                    child: const Text("Elegir archivo")),
                                OutlinedButton(
                                    style: Styles.buttonAppbar,
                                    onPressed: () async {
                                      if (responseInformacion.data[0]['logo'] ==
                                          '0') {
                                        if (await uploadFile(
                                            _pathLogotipo!.first.bytes!,
                                            _pathLogotipo!.first.name,
                                            context,
                                            "/logotipos/",
                                            "logo")) {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.green,
                                              Icons.done,
                                              'La imagen fue cargada correctamente',
                                              context);
                                          // ignore: use_build_context_synchronously
                                          context
                                              .read<LoginProvider>()
                                              .setImageDeleteLogo(
                                                  responseInformacion
                                                      .data['mensaje']);
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.red,
                                              Icons.error,
                                              // ignore: use_build_context_synchronously
                                              Provider.of<LoginProvider>(
                                                      context,
                                                      listen: false)
                                                  .mensaje,
                                              context);
                                        }
                                      } else {
                                        if (await updateFile(
                                            _pathLogotipo!.first.bytes!,
                                            _pathLogotipo!.first.name,
                                            context,
                                            "/logotipos/",
                                            "logo",
                                            logodelete,
                                            1)) {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.green,
                                              Icons.done,
                                              'La imagen fue cargada correctamente',
                                              context);
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.red,
                                              Icons.error,
                                              // ignore: use_build_context_synchronously
                                              Provider.of<LoginProvider>(
                                                      context,
                                                      listen: false)
                                                  .mensaje,
                                              context);
                                        }
                                      }
                                    },
                                    child: const Text("Subir archivo")),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          const Divider(),
                          SizedBox(
                            height: Adaptive.h(7),
                          ),
                          Text(
                            "IMAGEN DE PORTADA",
                            style: TextStyle(fontSize: Adaptive.sp(15)),
                          ),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          Text(
                            "Elige tu imagen de portada",
                            style: TextStyle(fontSize: Adaptive.sp(15)),
                          ),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          SizedBox(
                            height: Adaptive.h(60),
                            child: _portadaShow != null
                                ? Image.memory(_portadaShow!)
                                : responseInformacion.data[0]['portada'] == '0'
                                    ? const ColoredBox(color: Colors.grey)
                                    : Image.network(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "https://aqui.city/api/writable/" +
                                            responseInformacion.data[0]
                                                ['portada']),
                          ),
                          SizedBox(
                            height: Adaptive.h(4),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  _pathPortada =
                                      (await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowMultiple: false,
                                    allowedExtensions: [
                                      'png',
                                      'jpg',
                                      'jpeg',
                                      'heic'
                                    ],
                                  ))
                                          ?.files;
                                  setState(() {
                                    if (_pathPortada != null) {
                                      if (_pathPortada != null) {
                                        //passing file bytes and file name for API call
                                        _portadaShow =
                                            _pathPortada!.first.bytes!;
                                        // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Elegir archivo")),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (responseInformacion.data[0]['portada'] ==
                                      '0') {
                                    if (await uploadFile(
                                        _pathPortada!.first.bytes!,
                                        _pathPortada!.first.name,
                                        context,
                                        "/portadas/",
                                        "portada")) {
                                      // ignore: use_build_context_synchronously
                                      Message().mensaje(
                                          Colors.green,
                                          Icons.done,
                                          'La imagen fue cargada correctamente',
                                          context);
                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<LoginProvider>()
                                          .setImageDeletePortada(
                                              responseInformacion
                                                  .data['mensaje']);
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      Message().mensaje(
                                          Colors.red,
                                          Icons.error,
                                          // ignore: use_build_context_synchronously
                                          Provider.of<LoginProvider>(context,
                                                  listen: false)
                                              .mensaje,
                                          context);
                                    }
                                  } else {
                                    if (await updateFile(
                                        _pathPortada!.first.bytes!,
                                        _pathPortada!.first.name,
                                        context,
                                        "/portadas/",
                                        "portada",
                                        portadadelete,
                                        2)) {
                                      // ignore: use_build_context_synchronously
                                      Message().mensaje(
                                          Colors.green,
                                          Icons.done,
                                          'La imagen fue cargada correctamente',
                                          context);
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      Message().mensaje(
                                          Colors.red,
                                          Icons.error,
                                          // ignore: use_build_context_synchronously
                                          Provider.of<LoginProvider>(context,
                                                  listen: false)
                                              .mensaje,
                                          context);
                                    }
                                  }
                                },
                                child: const Text("Subir archivo")),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Adaptive.h(5),
                      ),

                      const Divider(),
                      Column(
                        children: [
                          Text(
                            "INGRESA EL CODIGO",
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
                                controller: codigo,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("CODIGO"),
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
                                if (await ApiCalls()
                                    .code(codigo.text, context)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Código validado', context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      // ignore: use_build_context_synchronously
                                      Provider.of<LoginProvider>(context,
                                              listen: false)
                                          .mensaje,
                                      context);
                                }
                              },
                              child: Text(
                                "Guardar datos",
                                style: TextStyle(fontSize: Adaptive.sp(12)),
                              )),
                          SizedBox(
                            height: Adaptive.h(5),
                          )
                        ],
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
