import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/custom_appbar_color.dart';
import 'package:aquicity/src/widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();

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
                        children: [
                          SizedBox(
                              width: Adaptive.w(80),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Adaptive.h(3),
                                  ),
                                  Text(
                                    "Iniciar sesión",
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(17),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(10),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(80),
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
                                    height: Adaptive.h(5),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(80),
                                    child: TextFormField(
                                      controller: password,
                                      obscureText:
                                          context.watch<LoginProvider>().login,
                                      decoration: Styles()
                                          .inputStylePasswordLogin(
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
                                    height: Adaptive.h(5),
                                  ),
                                  OutlinedButton(
                                      style: Styles.buttonAppbar,
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (await ApiCalls().login(
                                              correo.text,
                                              password.text,
                                              context)) {
                                            // ignore: use_build_context_synchronously
                                            context.vRouter.to('/dataAd');
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.amber,
                                                Icons.warning,
                                                // ignore: use_build_context_synchronously
                                                Provider.of<LoginProvider>(
                                                        context,
                                                        listen: false)
                                                    .mensaje,
                                                context);
                                          }
                                        }
                                      },
                                      child: const Text("Entrar")),
                                  SizedBox(
                                    height: Adaptive.h(4),
                                  ),
                                  OutlinedButton(
                                      style: Styles.buttonStyle2,
                                      onPressed: () {
                                        context.vRouter.to("/resetPassword");
                                      },
                                      child: const Text(
                                          "¿Olvidaste tu contraseña?"))
                                ],
                              )),
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
                                    "Iniciar sesión",
                                    style: TextStyle(
                                        fontSize: Adaptive.sp(17),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(10),
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
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(5),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    child: TextFormField(
                                      controller: password,
                                      obscureText:
                                          context.watch<LoginProvider>().passC,
                                      decoration: Styles()
                                          .inputStylePasswordLogin(
                                              "CONTRASEÑA", context),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      OutlinedButton(
                                          style: Styles.buttonAppbar,
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              if (await ApiCalls().login(
                                                  correo.text,
                                                  password.text,
                                                  context)) {
                                                // ignore: use_build_context_synchronously
                                                context.vRouter.to('/dataAd');
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                Message().mensaje(
                                                    Colors.amber,
                                                    Icons.warning,
                                                    // ignore: use_build_context_synchronously
                                                    Provider.of<LoginProvider>(
                                                            context,
                                                            listen: false)
                                                        .mensaje,
                                                    context);
                                              }
                                            }
                                          },
                                          child: const Text("Entrar")),
                                      SizedBox(
                                        width: Adaptive.w(4),
                                      ),
                                      OutlinedButton(
                                          style: Styles.buttonStyle2,
                                          onPressed: () {
                                            context.vRouter
                                                .to("/resetPassword");
                                          },
                                          child: const Text(
                                              "¿Olvidaste tu contraseña?"))
                                    ],
                                  )
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
