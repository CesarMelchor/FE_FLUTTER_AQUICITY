import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  TextEditingController video1 = TextEditingController();
  TextEditingController video2 = TextEditingController();
  TextEditingController video3 = TextEditingController();
  TextEditingController video4 = TextEditingController();
  TextEditingController video5 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 85, 76),
        title: const AppbarBusiness(),
      ),
      drawer: const DrawerBussiness(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
          children: [
            SizedBox(
              height: Adaptive.h(5),
            ),
            Text(
              "Añadir enlaces a videos cargados",
              style: TextStyle(fontSize: Adaptive.sp(15)),
            ),
            SizedBox(
              height: Adaptive.w(5),
            ),
            SizedBox(
              width: Adaptive.w(65),
              child: TextFormField(
                controller: video1,
                onChanged: (value) {},
                decoration: Styles().inputStyle1("VIDEO 1"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: Adaptive.h(3),
            ),
            SizedBox(
              width: Adaptive.w(65),
              child: TextFormField(
                controller: video2,
                onChanged: (value) {},
                decoration: Styles().inputStyle1("VIDEO 2"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: Adaptive.h(3),
            ),
            SizedBox(
              width: Adaptive.w(65),
              child: TextFormField(
                controller: video3,
                onChanged: (value) {},
                decoration: Styles().inputStyle1("VIDEO 3"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: Adaptive.h(3),
            ),
            SizedBox(
              width: Adaptive.w(65),
              child: TextFormField(
                controller: video4,
                onChanged: (value) {},
                decoration: Styles().inputStyle1("VIDEO 4"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: Adaptive.h(3),
            ),
            SizedBox(
              width: Adaptive.w(65),
              child: TextFormField(
                controller: video5,
                onChanged: (value) {},
                decoration: Styles().inputStyle1("VIDEO 5"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: Adaptive.h(7),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
              child: OutlinedButton(
                  style: Styles.buttonAppbar,
                  onPressed: () {},
                  child: const Text("Guardar datos")),
            )
          ],
        ),
      ),
    );
  }
}
