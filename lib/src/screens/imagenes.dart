import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:custom_qr_generator_2/custom_qr_generator.dart';
import 'package:cooky/cooky.dart' as cookie;

class ImagenesScreen extends StatefulWidget {
  const ImagenesScreen({super.key});

  @override
  State<ImagenesScreen> createState() => _ImagenesScreenState();
}

class _ImagenesScreenState extends State<ImagenesScreen> {
  String imagendelete = "";

  Uint8List? _logotipoShow;

  Uint8List? _portadaShow;

  Uint8List? _bannerShow;

  List<PlatformFile>? _pathLogotipo;

  List<PlatformFile>? _pathPortada;

  List<PlatformFile>? _pathBanner;

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

  static Future<bool> updateFile(List<int> file, String fileName,
      BuildContext context, locate, campo, last, opcion) async {
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
      // ignore: use_build_context_synchronously
      if (opcion == 1) {
        // ignore: use_build_context_synchronously
        context
            .read<LoginProvider>()
            .setImageDeleteLogo(response.data['mensaje']);
      }
      if (opcion == 2) {
        // ignore: use_build_context_synchronously
        context
            .read<LoginProvider>()
            .setImageDeletePortada(response.data['mensaje']);
      }
      if (opcion == 3) {
        // ignore: use_build_context_synchronously
        context
            .read<LoginProvider>()
            .setImageDeleteBanner(response.data['mensaje']);
      }

      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(response.data['mensaje']);
      return false;
    }
  }

  late Response response;
  Dio dio = Dio();

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response = await dio.get('https://aqui.city/api/public/v1/ad/$idsend');
    // ignore: use_build_context_synchronously
    context.read<LoginProvider>().setImageDeleteLogo(response.data[0]['logo']);
    // ignore: use_build_context_synchronously
    context
        .read<LoginProvider>()
        .setImageDeletePortada(response.data[0]['portada']);
    // ignore: use_build_context_synchronously
    context
        .read<LoginProvider>()
        .setImageDeleteBanner(response.data[0]['banner_lateral']);

    return response.data;
  }

  late final Future myFuture = obtainDataAd(context);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool responsive = false;
    if (size.width <= 844) {
      responsive = true;
    } else {
      responsive = false;
    }

    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                  title: const AppbarBusiness(),
                ),
                drawer: const DrawerBussiness(),
                body: ListView(
                  padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
                  children: [
                    SizedBox(
                      height: Adaptive.h(7),
                    ),
                    Text(
                      "LOGOTIPO",
                      style: TextStyle(fontSize: Adaptive.sp(15)),
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
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
                          : response.data[0]['logo'] == '0'
                              ? const ColoredBox(color: Colors.grey)
                              : Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "https://aqui.city/api/writable/" +
                                      response.data[0]['logo']),
                    ),
                    SizedBox(
                      height: Adaptive.h(4),
                    ),
                    Padding(
                      padding: responsive == true
                          ? EdgeInsets.symmetric(horizontal: Adaptive.w(5))
                          : EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
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
                                if (response.data[0]['logo'] == '0') {
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
                                            response.data['mensaje']);
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
                                      _pathLogotipo!.first.bytes!,
                                      _pathLogotipo!.first.name,
                                      context,
                                      "/logotipos/",
                                      "logo",
                                      Provider.of<LoginProvider>(context,
                                              listen: false)
                                          .imagenLogoDelete,
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
                          : response.data[0]['portada'] == '0'
                              ? const ColoredBox(color: Colors.grey)
                              : Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "https://aqui.city/api/writable/" +
                                      response.data[0]['portada']),
                    ),
                    SizedBox(
                      height: Adaptive.h(4),
                    ),
                    Padding(
                      padding: responsive == true
                          ? EdgeInsets.symmetric(horizontal: Adaptive.w(5))
                          : EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
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
                                      _portadaShow = _pathPortada!.first.bytes!;
                                      // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                    }
                                  }
                                });
                              },
                              child: const Text("Elegir archivo")),
                          OutlinedButton(
                              style: Styles.buttonAppbar,
                              onPressed: () async {
                                if (response.data[0]['portada'] == '0') {
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
                                            response.data['mensaje']);
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
                                      response.data[0]['portada'],
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
                    SizedBox(
                      height: Adaptive.h(7),
                    ),
                    Text(
                      "BANNER LATERAL",
                      style: TextStyle(fontSize: Adaptive.sp(15)),
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    Text(
                      "Elige tu banner lateral",
                      style: TextStyle(fontSize: Adaptive.sp(15)),
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    SizedBox(
                      height: Adaptive.h(60),
                      child: _bannerShow != null
                          ? Image.memory(_bannerShow!)
                          : response.data[0]['banner_lateral'] == '0'
                              ? const ColoredBox(color: Colors.grey)
                              : Image.network(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "https://aqui.city/api/writable/" +
                                      response.data[0]['banner_lateral']),
                    ),
                    SizedBox(
                      height: Adaptive.h(4),
                    ),
                    Padding(
                      padding: responsive == true
                          ? EdgeInsets.symmetric(horizontal: Adaptive.w(5))
                          : EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              style: Styles.buttonAppbar,
                              onPressed: () async {
                                _pathBanner =
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
                                  if (_pathBanner != null) {
                                    if (_pathBanner != null) {
                                      //passing file bytes and file name for API call
                                      _bannerShow = _pathBanner!.first.bytes!;
                                      // uploadFile(      _paths!.first.bytes!, _paths!.first.name);
                                    }
                                  }
                                });
                              },
                              child: const Text("Elegir archivo")),
                          OutlinedButton(
                              style: Styles.buttonAppbar,
                              onPressed: () async {
                                if (response.data[0]['banner_lateral'] == '0') {
                                  if (await uploadFile(
                                      _pathBanner!.first.bytes!,
                                      _pathBanner!.first.name,
                                      context,
                                      "/laterales/",
                                      "banner_lateral")) {
                                    // ignore: use_build_context_synchronously
                                    Message().mensaje(
                                        Colors.green,
                                        Icons.done,
                                        'La imagen fue cargada correctamente',
                                        context);
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<LoginProvider>()
                                        .setImageDeleteBanner(
                                            response.data['mensaje']);
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
                                      _pathBanner!.first.bytes!,
                                      _pathBanner!.first.name,
                                      context,
                                      "/laterales/",
                                      "banner_lateral",
                                      response.data[0]['banner_lateral'],
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
                      "CODIGOS QR",
                      style: TextStyle(fontSize: Adaptive.sp(15)),
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                      child: responsive == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "LINK ANUNCIO",
                                      style:
                                          TextStyle(fontSize: Adaptive.sp(14)),
                                    ),
                                    CustomPaint(
                                      painter: QrPainter(
                                          data:
                                              // ignore: prefer_interpolation_to_compose_strings
                                              'https://aqui.city/#/detailAd/' +
                                                  response.data[0]['user_id'],
                                          options: const QrOptions(
                                              shapes: QrShapes(
                                                  darkPixel:
                                                      QrPixelShapeRoundCorners(
                                                          cornerFraction: .5),
                                                  frame:
                                                      QrFrameShapeRoundCorners(
                                                          cornerFraction: .25),
                                                  ball: QrBallShapeRoundCorners(
                                                      cornerFraction: .25)),
                                              colors: QrColors(
                                                  dark: QrColorLinearGradient(
                                                      colors: [
                                                    Colors.blue,
                                                    Color.fromARGB(
                                                        255, 11, 87, 150)
                                                  ],
                                                      orientation:
                                                          GradientOrientation
                                                              .leftDiagonal)))),
                                      size: const Size(350, 350),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "TELÉFONO DE CONTACTO",
                                      style:
                                          TextStyle(fontSize: Adaptive.sp(14)),
                                    ),
                                    CustomPaint(
                                      painter: QrPainter(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          data: 'tel:' +
                                              response.data[0]['telefono'],
                                          options: const QrOptions(
                                              shapes: QrShapes(
                                                  darkPixel:
                                                      QrPixelShapeRoundCorners(
                                                          cornerFraction: .5),
                                                  frame:
                                                      QrFrameShapeRoundCorners(
                                                          cornerFraction: .25),
                                                  ball: QrBallShapeRoundCorners(
                                                      cornerFraction: .25)),
                                              colors: QrColors(
                                                  dark: QrColorLinearGradient(
                                                      colors: [
                                                    Colors.blue,
                                                    Color.fromARGB(
                                                        255, 11, 87, 150)
                                                  ],
                                                      orientation:
                                                          GradientOrientation
                                                              .leftDiagonal)))),
                                      size: const Size(350, 350),
                                    ),
                                  ],
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "LINK ANUNCIO",
                                      style:
                                          TextStyle(fontSize: Adaptive.sp(14)),
                                    ),
                                    CustomPaint(
                                      painter: QrPainter(
                                          data:
                                              // ignore: prefer_interpolation_to_compose_strings
                                              'https://aqui.city/#/detailAd/' +
                                                  response.data[0]['user_id'],
                                          options: const QrOptions(
                                              shapes: QrShapes(
                                                  darkPixel:
                                                      QrPixelShapeRoundCorners(
                                                          cornerFraction: .5),
                                                  frame:
                                                      QrFrameShapeRoundCorners(
                                                          cornerFraction: .25),
                                                  ball: QrBallShapeRoundCorners(
                                                      cornerFraction: .25)),
                                              colors: QrColors(
                                                  dark: QrColorLinearGradient(
                                                      colors: [
                                                    Colors.blue,
                                                    Color.fromARGB(
                                                        255, 11, 87, 150)
                                                  ],
                                                      orientation:
                                                          GradientOrientation
                                                              .leftDiagonal)))),
                                      size: const Size(350, 350),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "TELÉFONO DE CONTACTO",
                                      style:
                                          TextStyle(fontSize: Adaptive.sp(14)),
                                    ),
                                    CustomPaint(
                                      painter: QrPainter(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          data: 'tel:' +
                                              response.data[0]['telefono'],
                                          options: const QrOptions(
                                              shapes: QrShapes(
                                                  darkPixel:
                                                      QrPixelShapeRoundCorners(
                                                          cornerFraction: .5),
                                                  frame:
                                                      QrFrameShapeRoundCorners(
                                                          cornerFraction: .25),
                                                  ball: QrBallShapeRoundCorners(
                                                      cornerFraction: .25)),
                                              colors: QrColors(
                                                  dark: QrColorLinearGradient(
                                                      colors: [
                                                    Colors.blue,
                                                    Color.fromARGB(
                                                        255, 11, 87, 150)
                                                  ],
                                                      orientation:
                                                          GradientOrientation
                                                              .leftDiagonal)))),
                                      size: const Size(350, 350),
                                    ),
                                  ],
                                )
                              ],
                            ),
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    const Divider(),
                  ],
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
