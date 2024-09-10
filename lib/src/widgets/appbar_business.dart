import 'package:aquicity/src/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;

class AppbarBusiness extends StatefulWidget {
  const AppbarBusiness({super.key});

  @override
  State<AppbarBusiness> createState() => _AppbarBusinessState();
}

class _AppbarBusinessState extends State<AppbarBusiness> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              context.vRouter.to("/home");
              cookie.remove('id');
            },
            child: Text(
              "Cerrar sesión",
              style: TextStyle(fontSize: Adaptive.sp(13)),
            )),
        Expanded(child: Container()),
        InkWell(
          onTap: () {
            context.vRouter.to("/homeBusiness");
          },
          child: Text(
            "Negocio",
            style: TextStyle(
                color: Variables.principal, fontSize: Adaptive.sp(13)),
          ),
        ),
        SizedBox(
          width: Adaptive.w(1),
        ),
        Text(
          "Nombre del propietario",
          style:
              TextStyle(color: Variables.principal, fontSize: Adaptive.sp(13)),
        ),
      ],
    );
  }
}
