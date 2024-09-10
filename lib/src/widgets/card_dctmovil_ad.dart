import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class CardAdaquicity extends StatefulWidget {
  const CardAdaquicity({super.key});

  @override
  State<CardAdaquicity> createState() => _CardAdaquicityState();
}

class _CardAdaquicityState extends State<CardAdaquicity> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adaptive.w(20),
      height: Adaptive.h(55),
      child: Column(
        children: [
          SizedBox(
              width: Adaptive.w(20),
              height: Adaptive.h(15),
              child: InkWell(
                  onTap: () {
                    context.vRouter.to("/detailAd");
                  },
                  child: Image.asset(
                    "assets/images/portada.jpg",
                    fit: BoxFit.fill,
                  ))),
          SizedBox(
            width: Adaptive.w(20),
            child: Row(
              children: [
                const Column(
                  children: [
                    Text("nombre del negocio"),
                    Text("Abierto"),
                    Text("valoracion")
                  ],
                ),
                Expanded(child: Container()),
                SizedBox(
                    width: Adaptive.w(5),
                    child: Image.asset("assets/icons/favicon.png"))
              ],
            ),
          ),
          SizedBox(
            width: Adaptive.w(20),
            child: Row(
              children: [
                const Icon(Icons.phone),
                SizedBox(
                  width: Adaptive.w(1),
                ),
                const Text("9512913901")
              ],
            ),
          ),
          SizedBox(
            width: Adaptive.w(20),
            child: Row(
              children: [
                const Icon(Icons.gps_fixed),
                SizedBox(
                  width: Adaptive.w(1),
                ),
                const Text("direccion"),
              ],
            ),
          ),
          SizedBox(
            height: Adaptive.h(2),
          ),
          SizedBox(
              width: Adaptive.w(20),
              child: const Text(
                "descripcion",
              )),
          SizedBox(
            height: Adaptive.h(1),
          ),
          const Text("Redes sociales"),
          SizedBox(
            height: Adaptive.h(2),
          ),
          SizedBox(
            width: Adaptive.w(20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.facebook),
                Icon(Icons.install_desktop),
                Icon(Icons.web)
              ],
            ),
          )
        ],
      ),
    );
  }
}
