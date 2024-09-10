import 'package:aquicity/src/screens/admin/widgets/appbar_admin.dart';
import 'package:flutter/material.dart';
import 'package:cooky/cooky.dart' as cookie;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  context.vRouter.to("/banners");
                },
                child: Container(
                  color: const Color.fromARGB(255, 223, 223, 223),
                  width: Adaptive.w(25),
                  height: Adaptive.h(30),
                  child: const Center(child: Text("BANNERS")),
                ),
              ),
              InkWell(
                onTap: () {
                  context.vRouter.to("/anuncios");
                },
                child: Container(
                  color: const Color.fromARGB(255, 223, 223, 223),
                  width: Adaptive.w(25),
                  height: Adaptive.h(30),
                  child: const Center(child: Text("ANUNCIOS")),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
