import 'package:aquicity/src/providers/register_provider.dart';
import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/custom_appbar_color.dart';
import 'package:aquicity/src/widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatpassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
              child: Container(
                decoration: Styles.containerRegister,
                width: Adaptive.w(80),
                height: Adaptive.h(70),
                child: responsive == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: Adaptive.w(80),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Adaptive.h(3),
                                  ),
                                  Text(
                                    "Registrarse",
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(17),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(3),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(60),
                                    child: TextFormField(
                                      controller: nombre,
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyle1("NOMBRE DEL NEGOCIO"),
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
                                    width: Adaptive.w(60),
                                    child: TextFormField(
                                      controller: correo,
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyle1("CORREO"),
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
                                    width: Adaptive.w(60),
                                    child: TextFormField(
                                      controller: password,
                                      obscureText: context
                                          .watch<RegisterProvider>()
                                          .passC,
                                      decoration: Styles().inputStylePassword(
                                          "CONTRASEÑA", context),
                                      onChanged: (value) {
                                        value = value;
                                      },
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
                                    width: Adaptive.w(60),
                                    child: TextFormField(
                                      controller: repeatpassword,
                                      obscureText: context
                                          .watch<RegisterProvider>()
                                          .passConfirm,
                                      decoration: Styles()
                                          .inputStylePasswordConfirm(
                                              "CONFIRMAR CONTRASEÑA", context),
                                      onChanged: (value) {
                                        value = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(5),
                                  ),
                                  OutlinedButton(
                                      style: Styles.buttonAppbar,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (password.text ==
                                              repeatpassword.text) {
                                            if (await ApiCalls().register(
                                                nombre.text,
                                                correo.text,
                                                password.text,
                                                context)) {
                                              var idUser =
                                                  // ignore: use_build_context_synchronously
                                                  Provider.of<RegisterProvider>(
                                                          context,
                                                          listen: false)
                                                      .id
                                                      .toInt();
                                              // ignore: use_build_context_synchronously
                                              await ApiCalls().registerAd(
                                                  nombre.text, idUser, context);
                                              // ignore: use_build_context_synchronously
                                              await ApiCalls().registerMapa(
                                                  idUser, context);
                                              // ignore: use_build_context_synchronously
                                              context.vRouter.to("/login");
                                            }
                                          } else {
                                            //contraseñas diferentes
                                          }
                                        }
                                      },
                                      child: const Text("Crear mi cuenta"))
                                ],
                              )),
                          SizedBox(
                            height: Adaptive.h(2),
                          ),
                          OutlinedButton(
                              style: Styles.buttonStyle2,
                              onPressed: () {
                                context.vRouter.to("/login");
                              },
                              child: const Text("Ya soy miembro"))
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                              width: Adaptive.w(40),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Adaptive.h(3),
                                  ),
                                  Text(
                                    "Registrarse",
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(17),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(3),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    child: TextFormField(
                                      controller: nombre,
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyle1("NOMBRE DEL NEGOCIO"),
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
                                    width: Adaptive.w(30),
                                    child: TextFormField(
                                      controller: correo,
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyle1("CORREO"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        } else if (!value.contains('@')) {
                                          return "Formato incorrecto";
                                        } else if (!value.contains('.')) {
                                          return "Formato incorrecto";
                                        } else if (!value.contains('com')) {
                                          return "Formato incorrecto";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(3),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    child: TextFormField(
                                      controller: password,
                                      obscureText: context
                                          .watch<RegisterProvider>()
                                          .passC,
                                      decoration: Styles().inputStylePassword(
                                          "CONTRASEÑA", context),
                                      onChanged: (value) {
                                        value = value;
                                      },
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
                                    width: Adaptive.w(30),
                                    child: TextFormField(
                                      controller: repeatpassword,
                                      obscureText: context
                                          .watch<RegisterProvider>()
                                          .passConfirm,
                                      decoration: Styles()
                                          .inputStylePasswordConfirm(
                                              "CONFIRMAR CONTRASEÑA", context),
                                      onChanged: (value) {
                                        value = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(5),
                                  ),
                                  OutlinedButton(
                                      style: Styles.buttonAppbar,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (password.text ==
                                              repeatpassword.text) {
                                            if (await ApiCalls().register(
                                                '',
                                                correo.text,
                                                password.text,
                                                context)) {
                                              var idUser =
                                                  // ignore: use_build_context_synchronously
                                                  Provider.of<RegisterProvider>(
                                                          context,
                                                          listen: false)
                                                      .id
                                                      .toInt();
                                              // ignore: use_build_context_synchronously
                                              await ApiCalls().registerAd(
                                                  nombre.text, idUser, context);
                                              // ignore: use_build_context_synchronously
                                              await ApiCalls().registerMapa(
                                                  idUser, context);
                                              // ignore: use_build_context_synchronously
                                              context.vRouter.to("/login");
                                            }
                                          } else {
                                            //contraseñas diferentes
                                          }
                                        }
                                      },
                                      child: const Text("Crear mi cuenta"))
                                ],
                              )),
                          SizedBox(
                              width: Adaptive.w(40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/logos/dct-logo.png",
                                    width: Adaptive.w(30),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(7),
                                  ),
                                  OutlinedButton(
                                      style: Styles.buttonStyle2,
                                      onPressed: () {
                                        context.vRouter.to("/login");
                                      },
                                      child: const Text("Ya soy miembro"))
                                ],
                              ))
                        ],
                      ),
              ),
            ),
            const CustomFooter()
          ],
        ),
      ),
    );
  }
}
