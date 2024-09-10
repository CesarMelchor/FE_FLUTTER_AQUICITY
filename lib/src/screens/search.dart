import 'package:aquicity/src/utils/url_launcher.dart';
import 'package:aquicity/src/utils/variables.dart';
import 'package:aquicity/src/widgets/custom_appbar_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController searching = TextEditingController();

Response response = Response(requestOptions: RequestOptions());

List lista = [];

Dio dio = Dio();

Future obtainAds() async {
  response = await dio.get('https://aqui.city/api/public/v1/ads/search',
      queryParameters: {"buscar": Variables.buscar});
  lista = response.data;

  return response.data;
}

Future myFuture = obtainAds();

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Future obtainAdsIn() async {
      response = await dio.get('https://aqui.city/api/public/v1/ads/search',
          queryParameters: {"buscar": Variables.buscar});
      setState(() {
        lista = response.data;
      });
    }

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
                appBar: PreferredSize(
                    preferredSize: Size(Adaptive.w(100), Adaptive.h(10)),
                    child: const CustomAppbarColor()),
                body: ListView(
                  children: [
                    SizedBox(
                      height: Adaptive.h(10),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: Adaptive.w(80),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: searching,
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                floatingLabelStyle:
                                    const TextStyle(color: Colors.black),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      obtainAdsIn();
                                    },
                                    child: const Icon(Icons.search)),
                                suffixIconColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.focused)
                                            ? Colors.black
                                            : Colors.grey),
                                label: const Text('Buscar')),
                            onChanged: (value) {
                              setState(() {
                                Variables.buscar = value.toString();
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
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    SizedBox(
                      width: Adaptive.w(80),
                      height: Adaptive.h(100),
                      child: ResponsiveGridList(
                          minItemWidth: responsive == true
                              ? Adaptive.w(50)
                              : Adaptive.w(20),
                          children: [
                            for (var item in lista)
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap: item['facebook'] == "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            item['facebook']);
                                                      },
                                                child: Image.asset(
                                                  "assets/icons/facebook_5968764.png",
                                                )),
                                            InkWell(
                                                onTap: item['facebook'] == "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            item['youtube']);
                                                      },
                                                child: Image.asset(
                                                  "assets/icons/youtube.png",
                                                )),
                                            InkWell(
                                                onTap: item['facebook'] == "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            item['skype']);
                                                      },
                                                child: Image.asset(
                                                  "assets/icons/skype.png",
                                                )),
                                            InkWell(
                                                onTap: item['facebook'] == "no"
                                                    ? null
                                                    : () {
                                                        OpenLink.launchURL(
                                                            item['instagram']);
                                                      },
                                                child: Image.asset(
                                                  "assets/icons/instagram.png",
                                                )),
                                            InkWell(
                                                onTap: item['facebook'] == "no"
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
                          ]),
                    )
                  ],
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
