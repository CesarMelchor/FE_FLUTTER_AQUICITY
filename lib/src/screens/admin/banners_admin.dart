import 'dart:typed_data';
import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/screens/admin/widgets/appbar_admin.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  Uint8List? _bannerShow;

  List<PlatformFile>? _pathBanner;

  late Response apibannerNuevo;
  late Response apibannerEliminado;

  Dio dio = Dio();

  Future<bool> uploadBanner(
      List<int> file, BuildContext context, fileName) async {
    var dio = Dio();

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file,
        filename: fileName,
        contentType: MediaType("image", "png"),
      ),
      "locate": "/banners/",
    });
    apibannerNuevo = await dio.post(
        "https://aqui.city/api/public/v1/banners/uploadFile",
        data: formData);
    if (apibannerNuevo.statusCode == 200) {
      return true;
    } else {
      // ignore: use_build_context_synchronously
      context.read<LoginProvider>().setMesagge(apibannerNuevo.data['mensaje']);
      return false;
    }
  }

  Future<bool> deletebanner(BuildContext context, id, imagen) async {
    apibannerEliminado = await dio.post(
        'https://aqui.city/api/public/v1/banners/delete',
        data: {"image": imagen, "id": id});
    if (apibannerEliminado.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  late Response apibanners;

  Future obtainAnuncios(BuildContext context) async {
    apibanners = await dio.get('https://aqui.city/api/public/v1/banners');

    return apibanners.data;
  }

  late final Future myFuture = obtainAnuncios(context);

  @override
  Widget build(BuildContext context) {
    var admin = cookie.get('admin');
    if (admin == null) {
      context.vRouter.to('/home');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 85, 76),
        title: const AppbarAdmin(),
        leading: IconButton(
            onPressed: () {
              context.vRouter.to("/dashboard");
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView(
                  children: [
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BANNERS DE PORTADA"),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("AGREGAR NUEVO BANNER"),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Adaptive.h(40),
                          width: Adaptive.w(40),
                          child: _bannerShow != null
                              ? Image.memory(_bannerShow!)
                              : const ColoredBox(color: Colors.grey),
                        ),
                        SizedBox(
                          width: Adaptive.w(4),
                        ),
                        Column(
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
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            OutlinedButton(
                                style: Styles.buttonAppbar,
                                onPressed: () async {
                                  if (await uploadBanner(
                                      _pathBanner!.first.bytes!,
                                      context,
                                      _pathBanner!.first.name)) {
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
                                            apibannerNuevo.data['mensaje']);
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
                      ],
                    ),
                    SizedBox(
                      width: Adaptive.w(90),
                      height: Adaptive.h(100),
                      child: ResponsiveGridList(
                        horizontalGridSpacing:
                            16, // Horizontal space between grid items
                        verticalGridSpacing:
                            16, // Vertical space between grid items
                        horizontalGridMargin:
                            50, // Horizontal space around the grid
                        verticalGridMargin:
                            50, // Vertical space around the grid
                        minItemWidth:
                            300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                        minItemsPerRow:
                            1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                        maxItemsPerRow:
                            3, // The maximum items to show in a single row. Can be useful on large screens
                        children: [
                          Column(
                            children: [
                              for (var item in apibanners.data)
                                Column(
                                  children: [
                                    SizedBox(
                                      width: Adaptive.w(25),
                                      child: Column(
                                        children: [
                                          Image.network(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              "https://aqui.city/api/writable/" +
                                                  item['image'])
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Adaptive.h(2),
                                    ),
                                    OutlinedButton(
                                        onPressed: () async {
                                          if (await deletebanner(context,
                                              item['id'], item['image'])) {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Banner eliminado',
                                                context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.red,
                                                Icons.error,
                                                'Por favor, actualiza la página.',
                                                context);
                                          }
                                        },
                                        child: const Text("Eliminar"))
                                  ],
                                )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
