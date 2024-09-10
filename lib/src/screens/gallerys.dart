import 'package:aquicity/src/pages/galery_one.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../pages/galery_third.dart';
import '../pages/galery_two.dart';

class GallerysScreen extends StatefulWidget {
  const GallerysScreen({super.key});

  @override
  State<GallerysScreen> createState() => _GallerysScreenState();
}

class _GallerysScreenState extends State<GallerysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 85, 76),
        title: const AppbarBusiness(),
      ),
      drawer: const DrawerBussiness(),
      body: ListView(
        children: [
          SizedBox(height: Adaptive.h(5)),
          Row(
            children: [
              SizedBox(
                height: Adaptive.w(7),
              ),
              Text(
                "Galerías",
                style: TextStyle(fontSize: Adaptive.sp(15)),
              ),
            ],
          ),
          SizedBox(
            height: Adaptive.h(5),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab( text: "GALERIA 1",),
                    Tab(text: "GALERIA 2"),
                    Tab(text: "GALERIA 3"),
                  ],
                ),
                SizedBox(
                  width: Adaptive.w(100),
                  height: Adaptive.h(100),
                  child: const TabBarView(
                    children: [
                      GalerryOnePage(),
                      GalerryTwoPage(),
                      GalerryThirdPage(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
