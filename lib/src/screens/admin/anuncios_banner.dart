import 'package:aquicity/src/screens/admin/widgets/appbar_admin.dart';
import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;

class AnunciosScreen extends StatefulWidget {
  const AnunciosScreen({super.key});

  @override
  State<AnunciosScreen> createState() => _AnunciosScreenState();
}

class _AnunciosScreenState extends State<AnunciosScreen> {
  @override
  Widget build(BuildContext context) {
    var admin = cookie.get('admin');
    if (admin == null) {
      context.vRouter.to('/home');
    }

    late Response response;
    Dio dio = Dio();

    Future obtainAnuncios(BuildContext context) async {
      response = await dio.get('https://aqui.city/api/public/v1/ads/portada');

      return response.data;
    }

    late final Future myFuture = obtainAnuncios(context);

    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                  title: const AppbarAdmin(),
                  leading: IconButton(
                      onPressed: () {
                        context.vRouter.to("/dashboard");
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
                body: ListView(
                  children: [
                    SizedBox(
                      height: Adaptive.h(4),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ANUNCIOS REGISTRADOS ACTUALMENTE",
                          style: TextStyle(fontSize: Adaptive.sp(16)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    for (var item in response.data)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(20),
                                  child:
                                      Text(item['nombre'] ?? 'Sin informacion'),
                                ),
                                SizedBox(
                                  width: Adaptive.w(20),
                                  child: Text(item['active'] == "2"
                                      ? 'Inactivo'
                                      : 'Activo'),
                                ),
                                SizedBox(
                                  width: Adaptive.w(20),
                                  child: Text(item['updated_at'] != null
                                      // ignore: prefer_interpolation_to_compose_strings
                                      ? 'Fecha de registro : ' +
                                          item['updated_at']
                                      : 'Fecha no disponible'),
                                ),
                                OutlinedButton(
                                    onPressed: () async {
                                      if (item['active'] == "2") {
                                        if (await ApiCalls()
                                            .onCode(item['user_id'], context)) {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(Colors.green,
                                              Icons.done, 'Activado', context);
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.green,
                                              Icons.done,
                                              'Error, intenta más tarde o actualiza la página',
                                              context);
                                        }
                                      } else {
                                        if (await ApiCalls().offCode(
                                            item['user_id'], context)) {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.green,
                                              Icons.done,
                                              'Desactivado',
                                              context);
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.green,
                                              Icons.done,
                                              'Error, intenta más tarde o actualiza la página',
                                              context);
                                        }
                                      }
                                    },
                                    child: Text(item['auth'] == "2"
                                        ? 'Activar'
                                        : 'Desactivar')),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      )
                  ],
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
