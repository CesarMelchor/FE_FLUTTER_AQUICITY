import 'package:aquicity/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomFooter extends StatefulWidget {
  const CustomFooter({super.key});

  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool responsive = false;
    if (size.width <= 844) {
      responsive = true;
    } else {
      responsive = false;
    }

    return responsive == true
        ? Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Image.asset(
                  "assets/logos/dct-logo.png",
                  width: Adaptive.w(60),
                ),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                SizedBox(
                    width: Adaptive.w(80),
                    child: Text(
                      "Todo lo que buscas en la palma de tu mano.",
                      style: TextStyle(color: Variables.principal),
                    )),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                SizedBox(
                    width: Adaptive.w(25),
                    child: Text("CONTACTANOS",
                        style: TextStyle(color: Variables.principal))),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                SizedBox(
                    width: Adaptive.w(80),
                    child: Divider(
                      height: 2,
                      color: Variables.principal,
                    )),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Variables.principal,
                    ),
                    SizedBox(
                      width: Adaptive.w(3),
                    ),
                    Text("951 177 9795",
                        style: TextStyle(color: Variables.principal))
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      color: Variables.principal,
                    ),
                    SizedBox(
                      width: Adaptive.w(3),
                    ),
                    SizedBox(
                      width: Adaptive.w(70),
                      child: Text(
                          "Siracusa 207,primer piso, Santa Lucía del Camino, Oaxaca, CP 71240",
                          style: TextStyle(color: Variables.principal)),
                    )
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail,
                      color: Variables.principal,
                    ),
                    SizedBox(
                      width: Adaptive.w(3),
                    ),
                    Text("Email", style: TextStyle(color: Variables.principal))
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                SizedBox(
                    width: Adaptive.w(80),
                    child: Text("REDES SOCIALES",
                        style: TextStyle(color: Variables.principal))),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                SizedBox(
                    width: Adaptive.w(80),
                    child: Divider(
                      height: 2,
                      color: Variables.principal,
                    )),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Image.asset(
                                                    "assets/icons/facebook.png",
                                                    width: Adaptive.w(4),
                                                  ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        Image.asset(
                                                    "assets/icons/whatsapp.png",
                                                    width: Adaptive.w(4),
                                                  ),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                SizedBox(
                    width: Adaptive.w(80),
                    child: Text("Politica de privacidad",
                        style: TextStyle(color: Variables.principal))),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                SizedBox(
                    width: Adaptive.w(80),
                    child: Text("© Copyright 2023 aquicity",
                        style: TextStyle(color: Variables.principal))),
                SizedBox(
                  height: Adaptive.h(3),
                ),
              ],
            ),
          )
        : 
        // web
        Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Adaptive.h(2),
                    ),
                    Image.asset(
                      "assets/logos/dct-logo.png",
                      width: Adaptive.w(10),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    SizedBox(
                        width: Adaptive.w(25),
                        child: Text(
                          "Todo lo que buscas en la palma de tu mano.",
                          style: TextStyle(color: Variables.principal),
                        ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Adaptive.h(2),
                    ),
                    SizedBox(
                        width: Adaptive.w(35),
                        child: Text("CONTACTANOS",
                            style: TextStyle(color: Variables.principal))),
                    SizedBox(
                        width: Adaptive.w(35),
                        child: Divider(
                          height: 2,
                          color: Variables.principal,
                        )),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Variables.principal,
                        ),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        Text("951 177 9795",
                            style: TextStyle(color: Variables.principal))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.gps_fixed,
                          color: Variables.principal,
                        ),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                          width: Adaptive.w(30),
                          child: Text(
                              "Siracusa 207,primer piso, Santa Lucía del Camino, Oaxaca, CP 71240",
                              style: TextStyle(color: Variables.principal)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mail,
                          color: Variables.principal,
                        ),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        Text("Email",
                            style: TextStyle(color: Variables.principal))
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    SizedBox(
                        width: Adaptive.w(35),
                        child: Text("Politica de privacidad",
                            style: TextStyle(color: Variables.principal))),
                   
                  ],
                ),
                SizedBox(
                  width: Adaptive.w(3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Adaptive.h(2),
                    ),
                    SizedBox(
                        width: Adaptive.w(30),
                        child: Text("REDES SOCIALES",
                            style: TextStyle(color: Variables.principal))),
                    SizedBox(
                        width: Adaptive.w(20),
                        child: Divider(
                          height: 2,
                          color: Variables.principal,
                        )),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                       
                      Image.asset(
                        
                                                    "assets/icons/facebook.png",
                                                    width: Adaptive.w(2),
                                                  ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        Image.asset(
                                                    "assets/icons/whatsapp.png",
                                                    width: Adaptive.w(2),
                                                  ),
                      ],
                    ),
                     SizedBox(
                      height: Adaptive.h(3),
                    ),
                    SizedBox(
                        width: Adaptive.w(35),
                        child: Text("© Copyright 2023 aquicity",
                            style: TextStyle(color: Variables.principal))),
                  ],
                ),
              ],
            ),
          );
  }
}
