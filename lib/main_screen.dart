import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/utils/url_launcher.dart';
import 'package:aquicity/src/utils/variables.dart';
import 'package:aquicity/src/widgets/custom_appbar.dart';
import 'package:aquicity/src/widgets/custom_categorys.dart';
import 'package:aquicity/src/widgets/custom_footer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searching = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
        setState(() {});
      });
  }

  late Response response;
  late Response banner;
  Dio dio = Dio();

  Future<bool> getBanner(BuildContext context) async {
    banner = await dio.get('https://aqui.city/api/public/v1/banner',
        options: Options(
          headers: <String, dynamic>{'Access-Control-Allow-Origin': '*'},
        ));

    if (banner.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future obtainAds(BuildContext context) async {
    if (await getBanner(context)) {
      response = await dio.get('https://aqui.city/api/public/v1/ads');
      return response.data;
    }
  }

  late final Future myFuture = obtainAds(context);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool responsive = false;
    if (size.width <= 844) {
      responsive = true;
    } else {
      responsive = false;
    }

    return Scaffold(
      body: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
                ? Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        /* Stack(
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: Adaptive.w(100),
                      height: Adaptive.h(100),
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  Text("hola")
                ],
              ),*/
                        Container(
                          width: Adaptive.w(100),
                          height: Adaptive.h(100),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: const AssetImage(
                                      "assets/images/DIAPOSITIVA1.PNG"),
                                  fit: responsive == true
                                      ? BoxFit.fitHeight
                                      : BoxFit.fill)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(Adaptive.cm(0.3)),
                                child: const CustomAppbar(),
                              ),
                              SizedBox(
                                height: Adaptive.h(15),
                              ),
                              Text(
                                "Todo lo que buscas",
                                style: TextStyle(
                                    color: Variables.principal,
                                    fontSize: Variables.titulo1,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: Adaptive.h(0.5),
                              ),
                              Text(
                                "En la palma de tu mano",
                                style: TextStyle(
                                    color: Variables.principal,
                                    fontSize: Variables.titulo2),
                              ),
                              SizedBox(
                                height: Adaptive.h(10),
                              ),
                              SizedBox(
                                width: Adaptive.w(70),
                                child: TextFormField(
                                  style: TextStyle(color: Variables.principal),
                                  controller: searching,
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.white),
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            context.vRouter.to('/search');
                                          },
                                          child: const Icon(Icons.search)),
                                      suffixIconColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => states.contains(
                                                      MaterialState.focused)
                                                  ? Colors.white
                                                  : Colors.grey),
                                      label: const Text('Buscar')),
                                  onChanged: (value) {
                                    setState(() {
                                      Variables.buscar = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo no puede estar vacío";
                                    }
                                    if (!value.contains('@')) {
                                      return "Formato de correo inválido";
                                    }
                                    if (!value.contains('.')) {
                                      return "Formato de correo inválido";
                                    }
                                    if (!value.contains('com')) {
                                      return "Formato de correo inválido";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: Adaptive.h(10),
                              ),
                              const CustomCategorysHome(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        Image.network(
                          // ignore: prefer_interpolation_to_compose_strings
                          "https://aqui.city/api/writable/" +
                              banner.data[0]['image'],
                          width: Adaptive.w(80),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var item in response.data)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Adaptive.w(2)),
                                  child: SizedBox(
                                    width: responsive == true
                                        ? Adaptive.w(50)
                                        : Adaptive.w(20),
                                    height: responsive == true
                                        ? Adaptive.h(70)
                                        : Adaptive.h(65),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: responsive == true
                                                ? Adaptive.w(40)
                                                : Adaptive.w(20),
                                            height: responsive == true
                                                ? Adaptive.h(20)
                                                : Adaptive.h(15),
                                            child: InkWell(
                                                onTap: () {
                                                  cookie.set(
                                                      'ad', item['user_id'],
                                                      maxAge: const Duration(
                                                          days: 7));
                                                  context.vRouter.to(
                                                      '/detailAd/${item['user_id']}');
                                                },
                                                child: Image.network(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  "https://aqui.city/api/writable/" +
                                                      item['portada'],
                                                  fit: BoxFit.fill,
                                                ))),
                                        SizedBox(
                                          width: responsive == true
                                              ? Adaptive.w(40)
                                              : Adaptive.w(20),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(item['nombre'] ??
                                                      "Sin nombre"),
                                                  const Text("Abierto"),
                                                ],
                                              ),
                                              Expanded(child: Container()),
                                              SizedBox(
                                                  width: Adaptive.w(5),
                                                  child: Image.network(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    "https://aqui.city/api/writable/" +
                                                        item['logo'],
                                                    fit: BoxFit.fill,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsive == true
                                              ? Adaptive.w(40)
                                              : Adaptive.w(20),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.phone),
                                              SizedBox(
                                                width: Adaptive.w(1),
                                              ),
                                              Text(item['telefono'] ??
                                                  "Sin telefono")
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: responsive == true
                                              ? Adaptive.w(40)
                                              : Adaptive.w(20),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.gps_fixed),
                                              SizedBox(
                                                width: Adaptive.w(1),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(15),
                                                child: Text(item['direccion'] ??
                                                    "Sin direccion establecida"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        SizedBox(
                                            width: responsive == true
                                                ? Adaptive.w(40)
                                                : Adaptive.w(20),
                                            height: Adaptive.h(18),
                                            child: Text(
                                              item['descripcion'] ??
                                                  "Sin descripcion",
                                            )),
                                        SizedBox(
                                          height: Adaptive.h(1),
                                        ),
                                        const Text("Redes sociales"),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        SizedBox(
                                          width: responsive == true
                                              ? Adaptive.w(40)
                                              : Adaptive.w(20),
                                          height: Adaptive.h(2),
                                          child: item['active'] == '0' ? Container() : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                  onTap: item['facebook'] ==
                                                          "no"
                                                      ? null
                                                      : () {
                                                          OpenLink.launchURL(
                                                              item['facebook']);
                                                        },
                                                  child: Image.asset(
                                                    "assets/icons/facebook_5968764.png",
                                                  )),
                                              InkWell(
                                                  onTap: item['facebook'] ==
                                                          "no"
                                                      ? null
                                                      : () {
                                                          OpenLink.launchURL(
                                                              item['youtube']);
                                                        },
                                                  child: Image.asset(
                                                    "assets/icons/youtube.png",
                                                  )),
                                              InkWell(
                                                  onTap: item['facebook'] ==
                                                          "no"
                                                      ? null
                                                      : () {
                                                          OpenLink.launchURL(
                                                              item['skype']);
                                                        },
                                                  child: Image.asset(
                                                    "assets/icons/skype.png",
                                                  )),
                                              InkWell(
                                                  onTap:
                                                      item['facebook'] == "no"
                                                          ? null
                                                          : () {
                                                              OpenLink.launchURL(
                                                                  item[
                                                                      'instagram']);
                                                            },
                                                  child: Image.asset(
                                                    "assets/icons/instagram.png",
                                                  )),
                                              InkWell(
                                                  onTap: item['facebook'] ==
                                                          "no"
                                                      ? null
                                                      : () {
                                                          OpenLink.launchURL(
                                                              item['twitter']);
                                                        },
                                                  child: Image.asset(
                                                    "assets/icons/gorjeo.png",
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: Adaptive.w(5),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        SizedBox(
                            width: Adaptive.w(100),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Adaptive.w(10)),
                              child: responsive == true
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: Adaptive.w(80),
                                          child: const Text(
                                            "Este es el siguiente paso para hacer crecer tu negocio",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(5),
                                        ),
                                        OutlinedButton(
                                            onPressed: () {
                                              context.vRouter.to("/planes");
                                            },
                                            style: Styles.buttonAppbar,
                                            child: const Text(
                                              "Publica tu anuncio",
                                            ))
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        SizedBox(
                                          width: Adaptive.w(60),
                                          child: const Text(
                                            "Este es el siguiente paso para hacer crecer tu negocio",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        OutlinedButton(
                                            onPressed: () {
                                              context.vRouter.to("/planes");
                                            },
                                            style: Styles.buttonAppbar,
                                            child: const Text(
                                              "Publica tu anuncio",
                                            ))
                                      ],
                                    ),
                            )),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        const CustomFooter()
                      ],
                    ),
                  )
                : const CircularProgressIndicator();
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
