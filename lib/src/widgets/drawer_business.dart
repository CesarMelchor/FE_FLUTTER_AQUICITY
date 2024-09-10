import 'package:aquicity/src/utils/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;


class DrawerBussiness extends StatefulWidget {
  const DrawerBussiness({super.key});

  @override
  State<DrawerBussiness> createState() => _DrawerBussinessState();
}

class _DrawerBussinessState extends State<DrawerBussiness> {
  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 196, 75, 66),
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              Image.asset(
                "assets/logos/dct-logo.png",
                width: Adaptive.w(10),
              ),
              SizedBox(
                height: Adaptive.h(2),
              ),
              Text(
                "MENU",
                style: TextStyle(fontSize: Adaptive.sp(15)),
              )
            ],
          )),
          ExpansionTile(
            leading: const Icon(Icons.business),
            title: const Text("Tu negocio"),
            children: [
              ListTile(
                title: const Text("Datos del propietario"),
                onTap: () {
                  context.vRouter.to("/dataProperty");
                },
              ),
              ListTile(
                title: const Text("Datos del anuncio"),
                onTap: () {
                  context.vRouter.to("/dataAd");
                },
              ),
              ListTile(
                title: const Text("Posicionamiento"),
                onTap: () {
                  context.vRouter.to("/posicionamiento");
                },
              ),
              ListTile(
                title: const Text("Mapa"),
                onTap: () {
                  context.vRouter.to("/mapa");
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.perm_media),
            title: const Text("Multimedia"),
            children: [
              ListTile(
                title: const Text("Imágenes"),
                onTap: () {
                  context.vRouter.to("/imagenes");
                },
              ),
              ListTile(
                title: const Text("Galerías de fotos"),
                onTap: () {
                  context.vRouter.to("/gallerys");
                },
              ),
              ListTile(
                title: const Text("Videos"),
                onTap: () {
                  context.vRouter.to("/videos");
                },
              ),
              ListTile(
                title: const Text("Georeferencia"),
                onTap: () {
                  context.vRouter.to("/mapa");
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.info),
            title: const Text("Adicionales"),
            children: [
              ListTile(
                title: const Text("Información adicional"),
                onTap: () {
                  context.vRouter.to("/adicional");
                },
              ),
              ListTile(
                title: const Text("Ver anuncio"),
                onTap: () {
                  OpenLink.launchURL("https://aqui.city/#/detailAd/${cookie.get('ad')}");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
