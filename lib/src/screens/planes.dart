import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/custom_appbar_color.dart';
import 'package:aquicity/src/widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class PlanesScreen extends StatefulWidget {
  const PlanesScreen({super.key});

  @override
  State<PlanesScreen> createState() => _PlanesScreenState();
}

class _PlanesScreenState extends State<PlanesScreen> {
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
      appBar: PreferredSize(
          preferredSize: Size(Adaptive.w(100), Adaptive.h(10)),
          child: const CustomAppbarColor()),
      body: ListView(
        children: [
          Container(
            color: const Color.fromARGB(255, 0, 139, 253),
            child: Column(
              children: [
                SizedBox(
                  height: Adaptive.h(5),
                ),
                responsive == true
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: Styles.containerPlanes,
                            width: Adaptive.w(60),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Icon(Icons.confirmation_number_sharp),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("GRATUITO"),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("Portada"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Logo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Descripción de su anuncio"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Teléfono directo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Ubicación"),
                                SizedBox(
                                  height: Adaptive.h(5),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      context.vRouter.to("/register");
                                    },
                                    child: const Text("REGISTRATE")),
                                SizedBox(
                                  height: Adaptive.h(3),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Adaptive.h(2),
                          ),
                          Container(
                            width: Adaptive.w(60),
                            decoration: Styles.containerPlanes,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Icon(Icons.confirmation_number_sharp),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("650.00 + IVA"),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("Mensual con pago anual"),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("PREMIUM"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Portada"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Logo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Banner lateral"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Descripción de su anuncio"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Descripción adicional negocio"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("24/7 soporte"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Sitio WEB sin costo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text(
                                    "2 Galerías de imágenes con 10 imágenes"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("5 videos"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Horarios de atención"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Sucursales"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Teléfono directo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("WhatsApp directo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Ubicación"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Marketing"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text(
                                    "Botón para compartir redes sociales"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Landing Page"),
                                SizedBox(
                                  height: Adaptive.h(5),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      context.vRouter.to("/register");
                                    },
                                    child: const Text("REGISTRATE")),
                                SizedBox(
                                  height: Adaptive.h(3),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: Styles.containerPlanes,
                            width: Adaptive.w(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Icon(Icons.confirmation_number_sharp),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("GRATUITO"),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("Portada"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Logo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Descripción de su anuncio"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Teléfono directo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Ubicación"),
                                SizedBox(
                                  height: Adaptive.h(5),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      context.vRouter.to("/register");
                                    },
                                    child: const Text("REGISTRATE")),
                                SizedBox(
                                  height: Adaptive.h(3),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: Adaptive.w(20),
                            decoration: Styles.containerPlanes,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Icon(Icons.confirmation_number_sharp),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("650.00 + IVA"),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("Mensual con pago anual"),
                                SizedBox(
                                  height: Adaptive.h(3),
                                ),
                                const Text("PREMIUM"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Portada"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Logo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Banner lateral"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Descripción de su anuncio"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Descripción adicional negocio"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("24/7 soporte"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Sitio WEB sin costo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text(
                                    "2 Galerías de imágenes con 10 imágenes"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("5 videos"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Horarios de atención"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Sucursales"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Teléfono directo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("WhatsApp directo"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Ubicación"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Marketing"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text(
                                    "Botón para compartir redes sociales"),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                const Text("Landing Page"),
                                SizedBox(
                                  height: Adaptive.h(5),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      context.vRouter.to("/register");
                                    },
                                    child: const Text("REGISTRATE")),
                                SizedBox(
                                  height: Adaptive.h(3),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: Adaptive.h(7),
                ),
              ],
            ),
          ),
          const CustomFooter()
        ],
      ),
    );
  }
}
