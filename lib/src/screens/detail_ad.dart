import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/url_launcher.dart';
import 'package:aquicity/src/widgets/custom_appbar_color.dart';
import 'package:aquicity/src/widgets/custom_footer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:custom_qr_generator_2/custom_qr_generator.dart';

class DetailAdScreen extends StatefulWidget {
  const DetailAdScreen({super.key});

  @override
  State<DetailAdScreen> createState() => _DetailAdScreenState();
}

class _DetailAdScreenState extends State<DetailAdScreen> {
  String numero = "";

  late Response response;

  late Response responseMapa;
  Response responseGaleria1 = Response(requestOptions: RequestOptions());
  Response responseGaleria2 = Response(requestOptions: RequestOptions());
  Response responseGaleria3 = Response(requestOptions: RequestOptions());
  Response responseImagenes1 = Response(requestOptions: RequestOptions());
  Response responseImagenes2 = Response(requestOptions: RequestOptions());
  Response responseImagenes3 = Response(requestOptions: RequestOptions());

  late String ubicacion;

  Dio dio = Dio();
  var horario = "";
  late List<String> list1;

  Future obtainGalery(BuildContext context, id, galeria) async {
    switch (galeria) {
      case 1:
        responseGaleria1 = await dio.get(
            'https://aqui.city/api/public/v1/galeria',
            queryParameters: {"id": id, "galeria": galeria});
        if (responseGaleria1.statusCode == 200) {
          var idGa = responseGaleria1.data[0]['id'];
          // ignore: use_build_context_synchronously
          await obtainImagenes(context, idGa, 1);
        } else {
          // ignore: use_build_context_synchronously
          Message().mensaje(Colors.amber, Icons.warning,
              'Error al obtener imágenes de esta galería', context);
        }
      case 2:
        responseGaleria2 = await dio.get(
            'https://aqui.city/api/public/v1/galeria',
            queryParameters: {"id": id, "galeria": galeria});
        if (responseGaleria2.statusCode == 200) {
          // ignore: use_build_context_synchronously
          await obtainImagenes(context, responseGaleria2.data[0]['id'], 2);
        } else {
          // ignore: use_build_context_synchronously
          Message().mensaje(Colors.amber, Icons.warning,
              'Error al obtener imágenes de esta galería', context);
        }
      case 3:
        responseGaleria3 = await dio.get(
            'https://aqui.city/api/public/v1/galeria',
            queryParameters: {"id": id, "galeria": galeria});
        if (responseGaleria3.statusCode == 200) {
          // ignore: use_build_context_synchronously
          await obtainImagenes(context, responseGaleria3.data[0]['id'], 3);
        } else {
          // ignore: use_build_context_synchronously
          Message().mensaje(Colors.amber, Icons.warning,
              'Error al obtener imágenes de esta galería', context);
        }
    }
  }

  Future<bool> obtainImagenes(BuildContext context, galeria, numero) async {
    switch (numero) {
      case 1:
        responseImagenes1 = await dio.get(
            'https://aqui.city/api/public/v1/imagenes',
            queryParameters: {"galeria": galeria});
        return true;
      case 2:
        responseImagenes2 = await dio.get(
            'https://aqui.city/api/public/v1/imagenes',
            queryParameters: {"galeria": galeria});
        return true;
      case 3:
        responseImagenes3 = await dio.get(
            'https://aqui.city/api/public/v1/imagenes',
            queryParameters: {"galeria": galeria});
        return true;
      default:
        return false;
    }
  }

  Future<bool> obtainMapa(BuildContext context) async {
    responseMapa =
        await dio.get('https://aqui.city/api/public/v1/mapa/detail/$numero');

    ubicacion = responseMapa.data[0]['linkframe'];
    if (responseMapa.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future obtainDataAd(BuildContext context) async {
    if (await obtainMapa(context)) {
      response =
          await dio.get('https://aqui.city/api/public/v1/ad/detail/$numero');

      horario = response.data[0]['horarios'];
      list1 = horario.split("<");
      // ignore: use_build_context_synchronously
      await obtainGalery(context, numero, 1);
      // ignore: use_build_context_synchronously
      await obtainGalery(context, numero, 2);
      // ignore: use_build_context_synchronously
      await obtainGalery(context, numero, 3);

      return response.data;
    } else {
      return "error";
    }
  }

  late final Future myFuture = obtainDataAd(context);

  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    setState(() {
      numero = context.vRouter.pathParameters['id'].toString();
    });

    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size(Adaptive.w(100), Adaptive.h(10)),
                    child: const CustomAppbarColor()),
                body: response.data[0]['active'] == '0'
                    ?
                    //anuncios gratuitos
                    ListView(
                        children: [
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Adaptive.w(3)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: Adaptive.w(60),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "https://aqui.city/api/writable/" +
                                              response.data[0]['portada'],
                                          width: Adaptive.w(60),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(3),
                                        ),
                                        Row(
                                          children: [
                                            Image.network(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              "https://aqui.city/api/writable/" +
                                                  response.data[0]['logo'],
                                              width: Adaptive.w(10),
                                            ),
                                            SizedBox(
                                              width: Adaptive.w(5),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(60),
                                          child: Text(
                                            response.data[0]['descripcion'],
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.gps_fixed),
                                            SizedBox(
                                              width: Adaptive.w(1),
                                            ),
                                            InkWell(
                                                onTap: () {},
                                                child: SizedBox(
                                                    width: Adaptive.w(40),
                                                    child: Text(response.data[0]
                                                        ['direccion'])))
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone),
                                            SizedBox(
                                              width: Adaptive.w(2),
                                            ),
                                            Text(response.data[0]['telefono'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const CustomFooter()
                        ],
                      )

                    //anuncios pagados
                    : ListView(
                        children: [
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Adaptive.w(3)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: Adaptive.w(60),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "https://aqui.city/api/writable/" +
                                              response.data[0]['portada'],
                                          width: Adaptive.w(60),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(3),
                                        ),
                                        Row(
                                          children: [
                                            Image.network(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              "https://aqui.city/api/writable/" +
                                                  response.data[0]['logo'],
                                              width: Adaptive.w(10),
                                            ),
                                            SizedBox(
                                              width: Adaptive.w(5),
                                            ),
                                            Column(
                                              children: [
                                                Text(response.data[0]
                                                        ['nombre'] ??
                                                    'Sin nombre'),
                                                SizedBox(
                                                  height: Adaptive.h(2),
                                                ),
                                                const Text("Cerrado / Abierto")
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(60),
                                          child: Text(
                                            response.data[0]['descripcion'],
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.gps_fixed),
                                            SizedBox(
                                              width: Adaptive.w(1),
                                            ),
                                            InkWell(
                                                onTap: () {},
                                                child: SizedBox(
                                                    width: Adaptive.w(40),
                                                    child: Text(response.data[0]
                                                        ['direccion'])))
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone),
                                            SizedBox(
                                              width: Adaptive.w(2),
                                            ),
                                            Text(response.data[0]['telefono'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap: response.data[0]
                                                            ['facebook'] ==
                                                        "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            response.data[0][
                                                                    'facebook'] ??
                                                                'Sin nombre');
                                                      },
                                                child: Image.asset(
                                                    "assets/icons/facebook_5968764.png",
                                                    width: Adaptive.w(2))),
                                            InkWell(
                                                onTap: response.data[0]
                                                            ['youtube'] ==
                                                        "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            response.data[0][
                                                                    'youtube'] ??
                                                                'Sin nombre');
                                                      },
                                                child: Image.asset(
                                                    "assets/icons/youtube.png",
                                                    width: Adaptive.w(2))),
                                            InkWell(
                                                onTap: response.data[0]
                                                            ['skype'] ==
                                                        "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            response.data[0]
                                                                    ['skype'] ??
                                                                'Sin nombre');
                                                      },
                                                child: Image.asset(
                                                    "assets/icons/skype.png",
                                                    width: Adaptive.w(2))),
                                            InkWell(
                                                onTap: response.data[0]
                                                            ['instagram'] ==
                                                        "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(response
                                                                    .data[0]
                                                                ['instagram'] ??
                                                            'Sin nombre');
                                                      },
                                                child: Image.asset(
                                                    "assets/icons/instagram.png",
                                                    width: Adaptive.w(2))),
                                            InkWell(
                                                onTap: response.data[0]
                                                            ['twitter'] ==
                                                        "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            response.data[0][
                                                                    'twitter'] ??
                                                                'Sin nombre');
                                                      },
                                                child: Image.asset(
                                                  "assets/icons/gorjeo.png",
                                                  width: Adaptive.w(2),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        Text(response.data[0]
                                                ['descripcion_adicional'] ??
                                            "Sin descripción"),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  width: Adaptive.w(2),
                                ),
                                SizedBox(
                                    width: Adaptive.w(30),
                                    child: Column(
                                      children: [
                                        const Text("Nuestra ubicación"),
                                        SizedBox(
                                            width: Adaptive.w(30),
                                            height: Adaptive.h(50),
                                            child: WebViewWidget(
                                                controller: WebViewController()
                                                  ..loadRequest(
                                                    Uri.dataFromString('''<html>
            <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
            <body>$ubicacion</body></html>''', mimeType: 'text/html'),
                                                  ))),
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "https://aqui.city/api/writable/" +
                                              response.data[0]
                                                  ['banner_lateral'],
                                          width: Adaptive.w(30),
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(30),
                                          height: Adaptive.h(40),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: Adaptive.w(30),
                                                  child: const Center(
                                                      child: Text("Horarios"))),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Lunes : ${list1[0]} a ${list1[1]}   /   ${list1[2]} a ${list1[3]}")),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Martes : ${list1[4]} a ${list1[5]}   /   ${list1[6]} a ${list1[7]}")),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Miércoles : ${list1[8]} a ${list1[9]}   /   ${list1[10]} a ${list1[11]}")),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Jueves : ${list1[12]} a ${list1[13]}   /   ${list1[14]} a ${list1[15]}")),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Viernes : ${list1[16]} a ${list1[17]}   /   ${list1[18]} a ${list1[19]}")),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Sábado : ${list1[20]} a ${list1[21]}   /   ${list1[22]} a ${list1[23]}")),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Adaptive.h(2),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: Adaptive.w(30),
                                                      child: Text(
                                                          "Domingo : ${list1[0]} a ${list1[1]}   /   ${list1[2]} a ${list1[3]}")),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: Adaptive.h(5),
                                            ),
                                            const Text("Código QR"),
                                            SizedBox(
                                              height: Adaptive.h(3),
                                            ),
                                            CustomPaint(
                                              painter: QrPainter(
                                                  data:
                                                      'https://aqui.city/#/detailAd/$numero',
                                                  options: const QrOptions(
                                                      shapes: QrShapes(
                                                          darkPixel:
                                                              QrPixelShapeRoundCorners(
                                                                  cornerFraction:
                                                                      .5),
                                                          frame:
                                                              QrFrameShapeRoundCorners(
                                                                  cornerFraction:
                                                                      .25),
                                                          ball:
                                                              QrBallShapeRoundCorners(
                                                                  cornerFraction:
                                                                      .25)),
                                                      colors: QrColors(
                                                          dark: QrColorLinearGradient(
                                                              colors: [
                                                            Colors.blue,
                                                            Color.fromARGB(255,
                                                                11, 87, 150)
                                                          ],
                                                              orientation:
                                                                  GradientOrientation
                                                                      .leftDiagonal)))),
                                              size: const Size(350, 350),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Adaptive.h(15),
                          ),
                          SizedBox(
                              width: Adaptive.w(100),
                              child: const Center(child: Text("MULTIMEDIA"))),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                const TabBar(
                                  labelColor: Colors.black,
                                  tabs: [
                                    Tab(
                                      text: "GALERIA 1",
                                    ),
                                    Tab(text: "GALERIA 2"),
                                    Tab(text: "GALERIA 3"),
                                  ],
                                ),
                                SizedBox(
                                  width: Adaptive.w(100),
                                  height: Adaptive.h(100),
                                  child: TabBarView(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            for (var item
                                                in responseImagenes1.data)
                                              responseImagenes1.data == null
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Adaptive.h(3),
                                                        ),
                                                        SizedBox(
                                                          width: Adaptive.w(70),
                                                          child: Image.network(
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "https://aqui.city/api/writable/" +
                                                                item['url'],
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: Adaptive.h(3),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                Adaptive.w(70),
                                                            child: item['descripcion'] == 'no' ? 
                                                            Container() : Text(item['descripcion'])),
                                                        SizedBox(
                                                          height: Adaptive.h(5),
                                                        )
                                                      ],
                                                    )
                                          ],
                                        ),
                                      ),
                                      // galeria 2
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            for (var item
                                                in responseImagenes2.data)
                                              responseImagenes2.data == null
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Adaptive.h(3),
                                                        ),
                                                        SizedBox(
                                                          width: Adaptive.w(70),
                                                          child: Image.network(
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "https://aqui.city/api/writable/" +
                                                                item['url'],
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: Adaptive.h(3),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                Adaptive.w(70),
                                                            child: item['descripcion'] == 'no' ? 
                                                            Container() : Text(item['descripcion'])),
                                                        SizedBox(
                                                          height: Adaptive.h(5),
                                                        )
                                                      ],
                                                    )
                                          ],
                                        ),
                                      ),
                                      // galeria 3
                                      SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            for (var item
                                                in responseImagenes3.data)
                                              responseImagenes3.data == null
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Adaptive.h(3),
                                                        ),
                                                        SizedBox(
                                                          width: Adaptive.w(70),
                                                          child: Image.network(
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            "https://aqui.city/api/writable/" +
                                                                item['url'],
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: Adaptive.h(3),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                Adaptive.w(70),
                                                            child: item['descripcion'] == 'no' ? 
                                                            Container() : Text(item['descripcion'])),
                                                        SizedBox(
                                                          height: Adaptive.h(5),
                                                        )
                                                      ],
                                                    )
                                          ],
                                        ),
                                      ),
                                      //videos

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const CustomFooter()
                        ],
                      ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
