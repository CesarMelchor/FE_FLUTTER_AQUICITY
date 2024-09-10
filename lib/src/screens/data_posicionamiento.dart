import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PosicionamientoScreen extends StatefulWidget {
  const PosicionamientoScreen({super.key});

  @override
  State<PosicionamientoScreen> createState() => _PosicionamientoScreenState();
}

class _PosicionamientoScreenState extends State<PosicionamientoScreen> {
  TextEditingController codigo = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 214, 85, 76),
          title: const AppbarBusiness(),
        ),
        drawer: const DrawerBussiness(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Adaptive.h(5),
              ),
              Text(
                "Posicionamiento",
                style: TextStyle(fontSize: Adaptive.sp(15)),
              ),
              SizedBox(
                height: Adaptive.h(5),
              ),
              const Divider(),
              Text(
                "INGRESA EL CODIGO",
                style: TextStyle(fontSize: Adaptive.sp(15)),
              ),
              SizedBox(
                height: Adaptive.h(5),
              ),
              SizedBox(
                height: Adaptive.h(5),
              ),
              SizedBox(
                width: Adaptive.w(50),
                child: SizedBox(
                  width: Adaptive.w(30),
                  child: TextFormField(
                    controller: codigo,
                    onChanged: (value) {},
                    decoration: Styles().inputStyle1("CODIGO"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Este campo no puede estar vacío";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Adaptive.h(7),
              ),
              OutlinedButton(
                  style: Styles.buttonAppbar,
                  onPressed: () async {
                    if (await ApiCalls().code(codigo.text, context)) {
                      // ignore: use_build_context_synchronously
                      Message().mensaje(
                          Colors.green, Icons.done, 'Código validado', context);
                    } else {
                      // ignore: use_build_context_synchronously
                      Message().mensaje(
                          Colors.red,
                          Icons.error,
                          // ignore: use_build_context_synchronously
                          Provider.of<LoginProvider>(context, listen: false)
                              .mensaje,
                          context);
                    }
                  },
                  child: Text(
                    "Guardar datos",
                    style: TextStyle(fontSize: Adaptive.sp(12)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
