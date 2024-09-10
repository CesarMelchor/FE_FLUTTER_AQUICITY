import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cooky/cooky.dart' as cookie;


class AppbarAdmin extends StatefulWidget {
  const AppbarAdmin({super.key});

  @override
  State<AppbarAdmin> createState() => _AppbarAdminState();
}

class _AppbarAdminState extends State<AppbarAdmin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              context.vRouter.to("/home");
              cookie.remove('admin');
            },
            child: Text("Cerrar sesión", style: TextStyle(fontSize: Adaptive.sp(13)),)),
        Expanded(child: Container()),
        SizedBox(
          width: Adaptive.w(1),
        ),
      ],
    );
  }
}
