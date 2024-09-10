import 'dart:typed_data';

import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;

class GalerryThirdPage extends StatefulWidget {
  const GalerryThirdPage({super.key});

  @override
  State<GalerryThirdPage> createState() => _GalerryThirdPageState();
}

class _GalerryThirdPageState extends State<GalerryThirdPage> {
  var idsend = cookie.get('id');

  TextEditingController descripcion1 = TextEditingController(text: "");
  TextEditingController descripcion2 = TextEditingController(text: "");
  TextEditingController descripcion3 = TextEditingController(text: "");
  TextEditingController descripcion4 = TextEditingController(text: "");
  TextEditingController descripcion5 = TextEditingController(text: "");

  String imagendelete1 = "";
  String imagendelete2 = "";
  String imagendelete3 = "";
  String imagendelete4 = "";
  String imagendelete5 = "";
  String idGaleryRequest = "";

  String tipe1 = "subir";
  String tipe2 = "subir";
  String tipe3 = "subir";
  String tipe4 = "subir";
  String tipe5 = "subir";

  Uint8List? _imagen1Show;
  Uint8List? _imagen2Show;
  Uint8List? _imagen3Show;
  Uint8List? _imagen4Show;
  Uint8List? _imagen5Show;

  List<PlatformFile>? _pathImagen1;
  List<PlatformFile>? _pathImagen2;
  List<PlatformFile>? _pathImagen3;
  List<PlatformFile>? _pathImagen4;
  List<PlatformFile>? _pathImagen5;

  late Response listImagenes;
  late Response galeria;
  late Response upload;
  Dio dio = Dio();

  Future<bool> uploadFile(List<int> file, String fileName, BuildContext context,
      idGalery, descripcionImagen, tipo, lastImage, numImagen) async {
    var dio = Dio();

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      ),
      "galeria_id": idGalery,
      "descripcion": descripcionImagen,
      "tipo": tipo,
      "locate": "/galerias/",
      "image_last": lastImage
    });

    upload = await dio.post("https://aqui.city/api/public/v1/imagenes/upload",
        data: formData);
    if (upload.statusCode == 200) {
      switch (numImagen) {
        case 1:
          imagendelete1 = upload.data['mensaje'];
          tipe1 = "eliminar";
          break;
        case 2:
          imagendelete2 = upload.data['mensaje'];
          tipe2 = "eliminar";
          break;
        case 3:
          imagendelete3 = upload.data['mensaje'];
          tipe3 = "eliminar";
          break;
        case 4:
          imagendelete4 = upload.data['mensaje'];
          tipe4 = "eliminar";
          break;
        case 5:
          imagendelete5 = upload.data['mensaje'];
          tipe5 = "eliminar";
          break;
        default:
      }

      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(upload.data['mensaje']);
      return false;
    }
  }

  Future<bool> getGaleria() async {
    galeria = await dio.get('https://aqui.city/api/public/v1/galeria',
        queryParameters: {"id": idsend, "galeria": "3"});
    if (galeria.statusCode == 200) {
      idGaleryRequest = galeria.data[0]['id'];
      return true;
    } else {
      return false;
    }
  }

  Future getImagenes() async {
    if (await getGaleria()) {
      listImagenes = await dio.get('https://aqui.city/api/public/v1/imagenes',
          queryParameters: {"galeria": idGaleryRequest});
      imagendelete1 = listImagenes.data[0]['url'];
      imagendelete2 = listImagenes.data[1]['url'];
      imagendelete3 = listImagenes.data[2]['url'];
      imagendelete4 = listImagenes.data[3]['url'];
      imagendelete5 = listImagenes.data[4]['url'];

      descripcion1.text = listImagenes.data[0]['descripcion'].toString();
      descripcion2.text = listImagenes.data[1]['descripcion'].toString();
      descripcion3.text = listImagenes.data[2]['descripcion'].toString();
      descripcion4.text = listImagenes.data[3]['descripcion'].toString();
      descripcion5.text = listImagenes.data[4]['descripcion'].toString();

      if (listImagenes.data[0]['url'] != "1") {
        tipe1 = "eliminar";
      }
      if (listImagenes.data[1]['url'] != "2") {
        tipe2 = "eliminar";
      }
      if (listImagenes.data[2]['url'] != "3") {
        tipe3 = "eliminar";
      }
      if (listImagenes.data[3]['url'] != "4") {
        tipe4 = "eliminar";
      }
      if (listImagenes.data[4]['url'] != "5") {
        tipe5 = "eliminar";
      }

      return listImagenes.data;
    } else {
      return "error";
    }
  }

  late final Future myFuture = getImagenes();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        Text(
                          "Elige las imágenes para esta galería",
                          style: TextStyle(fontSize: Adaptive.sp(15)),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          height: Adaptive.h(30),
                          child: _imagen1Show != null
                              ? Image.memory(_imagen1Show!)
                              : listImagenes.data[0]['url'] == '1'
                                  ? Container(
                                      width: Adaptive.w(50),
                                      height: Adaptive.h(15),
                                      color: Colors.grey,
                                    )
                                  : Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://aqui.city/api/writable/" +
                                          listImagenes.data[0]['url']),
                        ),
                        SizedBox(
                          height: Adaptive.h(4),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          child: TextFormField(
                            maxLength: 100,
                            controller: descripcion1,
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
                          height: Adaptive.h(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  _pathImagen1 =
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
                                    if (_pathImagen1 != null) {
                                      if (_pathImagen1 != null) {
                                        //passing file bytes and file name for API call
                                        _imagen1Show =
                                            _pathImagen1!.first.bytes!;
                                        // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Elegir archivo")),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (await uploadFile(
                                      _pathImagen1!.first.bytes!,
                                      _pathImagen1!.first.name,
                                      context,
                                      idGaleryRequest,
                                      descripcion1.text,
                                      tipe1,
                                      imagendelete1,
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
                                        Provider.of<LoginProvider>(context,
                                                listen: false)
                                            .mensaje,
                                        context);
                                  }
                                },
                                child: const Text("Subir archivo")),
                          ],
                        ),

                        //imagen 2
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          height: Adaptive.h(30),
                          child: _imagen2Show != null
                              ? Image.memory(_imagen2Show!)
                              : listImagenes.data[1]['url'] == '2'
                                  ? Container(
                                      width: Adaptive.w(50),
                                      height: Adaptive.h(15),
                                      color: Colors.grey,
                                    )
                                  : Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://aqui.city/api/writable/" +
                                          listImagenes.data[1]['url']),
                        ),
                        SizedBox(
                          height: Adaptive.h(4),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          child: TextFormField(
                            maxLength: 100,
                            controller: descripcion2,
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
                          height: Adaptive.h(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  _pathImagen2 =
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
                                    if (_pathImagen2 != null) {
                                      if (_pathImagen2 != null) {
                                        //passing file bytes and file name for API call
                                        _imagen2Show =
                                            _pathImagen2!.first.bytes!;
                                        // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Elegir archivo")),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (await uploadFile(
                                      _pathImagen2!.first.bytes!,
                                      _pathImagen2!.first.name,
                                      context,
                                      idGaleryRequest,
                                      descripcion2.text,
                                      tipe2,
                                      imagendelete2,
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
                                },
                                child: const Text("Subir archivo")),
                          ],
                        ),

                        //imagen 3

                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          height: Adaptive.h(30),
                          child: _imagen3Show != null
                              ? Image.memory(_imagen3Show!)
                              : listImagenes.data[2]['url'] == '3'
                                  ? Container(
                                      width: Adaptive.w(50),
                                      height: Adaptive.h(15),
                                      color: Colors.grey,
                                    )
                                  : Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://aqui.city/api/writable/" +
                                          listImagenes.data[2]['url']),
                        ),
                        SizedBox(
                          height: Adaptive.h(4),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          child: TextFormField(
                            maxLength: 100,
                            controller: descripcion3,
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
                          height: Adaptive.h(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  _pathImagen3 =
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
                                    if (_pathImagen3 != null) {
                                      if (_pathImagen3 != null) {
                                        //passing file bytes and file name for API call
                                        _imagen3Show =
                                            _pathImagen3!.first.bytes!;
                                        // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Elegir archivo")),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (await uploadFile(
                                      _pathImagen3!.first.bytes!,
                                      _pathImagen3!.first.name,
                                      context,
                                      idGaleryRequest,
                                      descripcion3.text,
                                      tipe3,
                                      imagendelete3,
                                      3)) {
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
                                },
                                child: const Text("Subir archivo")),
                          ],
                        ),

                        //imagen 4

                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          height: Adaptive.h(30),
                          child: _imagen4Show != null
                              ? Image.memory(_imagen4Show!)
                              : listImagenes.data[3]['url'] == '4'
                                  ? Container(
                                      width: Adaptive.w(50),
                                      height: Adaptive.h(15),
                                      color: Colors.grey,
                                    )
                                  : Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://aqui.city/api/writable/" +
                                          listImagenes.data[3]['url']),
                        ),
                        SizedBox(
                          height: Adaptive.h(4),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          child: TextFormField(
                            maxLength: 100,
                            controller: descripcion4,
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
                          height: Adaptive.h(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  _pathImagen4 =
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
                                    if (_pathImagen4 != null) {
                                      if (_pathImagen4 != null) {
                                        //passing file bytes and file name for API call
                                        _imagen4Show =
                                            _pathImagen4!.first.bytes!;
                                        // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Elegir archivo")),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (await uploadFile(
                                      _pathImagen4!.first.bytes!,
                                      _pathImagen4!.first.name,
                                      context,
                                      idGaleryRequest,
                                      descripcion4.text,
                                      tipe4,
                                      imagendelete4,
                                      4)) {
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
                                },
                                child: const Text("Subir archivo")),
                          ],
                        ),

                        //imagen 5

                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                          height: Adaptive.h(30),
                          child: _imagen5Show != null
                              ? Image.memory(_imagen5Show!)
                              : listImagenes.data[4]['url'] == '5'
                                  ? Container(
                                      width: Adaptive.w(50),
                                      height: Adaptive.h(15),
                                      color: Colors.grey,
                                    )
                                  : Image.network(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "https://aqui.city/api/writable/" +
                                          listImagenes.data[4]['url']),
                        ),
                        SizedBox(
                          height: Adaptive.h(4),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          child: TextFormField(
                            maxLength: 100,
                            controller: descripcion5,
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
                          height: Adaptive.h(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  _pathImagen5 =
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
                                    if (_pathImagen5 != null) {
                                      if (_pathImagen5 != null) {
                                        //passing file bytes and file name for API call
                                        _imagen5Show =
                                            _pathImagen5!.first.bytes!;
                                        // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                      }
                                    }
                                  });
                                },
                                child: const Text("Elegir archivo")),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (await uploadFile(
                                      _pathImagen5!.first.bytes!,
                                      _pathImagen5!.first.name,
                                      context,
                                      idGaleryRequest,
                                      descripcion5.text,
                                      tipe5,
                                      imagendelete5,
                                      5)) {
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
                                },
                                child: const Text("Subir archivo")),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
