import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/custom_appbar_color.dart';
import 'package:aquicity/src/widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController newpass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                child: Row(
                  children: [
                    SizedBox(
                        width: Adaptive.w(40),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Adaptive.h(10),
                            ),
                            Text(
                              "Recuperar contraseña",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(17),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Adaptive.h(5),
                            ),
                            SizedBox(
                              width: Adaptive.w(30),
                              child: TextFormField(
                                controller: correo,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("CORREO"),
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
                                controller: telefono,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("TELEFONO"),
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
                                controller: newpass,
                                onChanged: (value) {},
                                decoration: Styles().inputStyle1("CONTRASEÑA"),
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
                                    if (await ApiCalls().updatePassword(
                                        correo.text,
                                        telefono.text,
                                        newpass.text,
                                        context)) {
                                      // ignore: use_build_context_synchronously
                                      Message().mensaje(
                                          Colors.green,
                                          Icons.done,
                                          'Contraseña actualizada',
                                          context);
                                      // ignore: use_build_context_synchronously
                                      context.vRouter.to("/login");
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      Message().mensaje(
                                          Colors.red,
                                          Icons.error,
                                          'Error al actualizar, revise los datos',
                                          context);
                                    }
                                  } else {}
                                },
                                child: const Text("Restablecer contraseña")),
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
