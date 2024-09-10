import 'package:aquicity/src/free/admin_free.dart';
import 'package:aquicity/src/pages/data_ad.dart';
import 'package:aquicity/src/pages/data_social.dart';
import 'package:aquicity/src/pages/describe.dart';
import 'package:aquicity/src/pages/word_clave.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cooky/cooky.dart' as cookie;
import 'package:vrouter/vrouter.dart';

class DataAdScreen extends StatefulWidget {
  const DataAdScreen({super.key});

  @override
  State<DataAdScreen> createState() => _DataAdScreenState();
}

class _DataAdScreenState extends State<DataAdScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController telefono = TextEditingController();

  var idsend = cookie.get('id');
  late Response response;
  Dio dio = Dio();
  String estado = "";

  Future obtainDataAd(BuildContext context) async {
    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    estado = response.data[0]['active'];

    return response.data;
  }

  late final Future myFuture = obtainDataAd(context);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var id = cookie.get('id');
    if (id == null) {
      context.vRouter.to('/home');
    }

    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? estado == '0'
                  ? const AdminFreeScreen()
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                        title: const AppbarBusiness(),
                      ),
                      drawer:
                          estado == '0' ? Container() : const DrawerBussiness(),
                      body: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: Adaptive.h(5),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(7),
                                ),
                                Text(
                                  "Datos del anuncio",
                                  style: TextStyle(fontSize: Adaptive.sp(15)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(10),
                            ),
                            DefaultTabController(
                              length: 4,
                              child: Column(
                                children: [
                                  const TabBar(
                                    labelColor: Colors.black,
                                    tabs: [
                                      Tab(
                                        text: "Datos básicos del anuncio",
                                      ),
                                      Tab(text: "Redes sociales"),
                                      Tab(text: "Palabras clave"),
                                      Tab(text: "Describe tu negocio"),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(100),
                                    height: Adaptive.h(100),
                                    child: const TabBarView(
                                      children: [
                                        DataAdPage(),
                                        DataSocialPage(),
                                        WordClavePage(),
                                        DescribePage(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
              : const CircularProgressIndicator();
        });
  }
}
