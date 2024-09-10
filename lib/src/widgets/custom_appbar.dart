import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/logos/dct-logo.png",
          width: Adaptive.w(7),
        ),
        Expanded(child: Container()),
        InkWell(
            onTap: () {
              context.vRouter.to("/home");
            },
            child: Text(
              "Inicio",
              style: TextStyle(color: Variables.principal),
            )),
        SizedBox(
          width: Adaptive.w(1),
        ),
        InkWell(
            onTap: () {
              context.vRouter.to("/login");
            },
            child: Text(
              "Iniciar sesión",
              style: TextStyle(color: Variables.principal),
            )),
        SizedBox(
          width: Adaptive.w(2),
        ),
        OutlinedButton(
            onPressed: () {
              context.vRouter.to("/planes");
            },
            style: Styles.buttonAppbar,
            child: Text(
              "Publica tu anuncio",
              style: TextStyle(color: Variables.principal),
            ))
      ],
    );
  }
}
