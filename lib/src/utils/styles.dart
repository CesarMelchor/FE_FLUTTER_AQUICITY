import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

class Styles {
  InputDecoration inputStyle1(label) {
    return InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        label: Text(label));
  }

  InputDecoration inputStylePassword(label, BuildContext context) {
    return InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            context.read<RegisterProvider>().setLoginCredencial();
          },
          icon: Icon(context.watch<RegisterProvider>().passC == false
              ? Icons.visibility
              : Icons.visibility_off),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        label: Text(label));
  }

  InputDecoration inputStylePasswordLogin(label, BuildContext context) {
    return InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            context.read<LoginProvider>().setLoginCredencial();
          },
          icon: Icon(context.watch<LoginProvider>().passC == false
              ? Icons.visibility
              : Icons.visibility_off),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        label: Text(label));
  }

  InputDecoration inputStylePasswordConfirm(label, BuildContext context) {
    return InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            context.read<RegisterProvider>().setLoginCredencialConfirm();
          },
          icon: Icon(context.watch<RegisterProvider>().passConfirm == false
              ? Icons.visibility
              : Icons.visibility_off),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        floatingLabelStyle: const TextStyle(color: Colors.blue),
        label: Text(label));
  }

  static ButtonStyle buttonAppbar = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue,
    minimumSize: Size(Adaptive.w(4.5), Adaptive.h(6)),
    padding: const EdgeInsets.symmetric(horizontal: 25),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  static ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
    foregroundColor: Colors.blue,
    backgroundColor: Colors.white,
    minimumSize: Size(Adaptive.w(4.5), Adaptive.h(6)),
    padding: const EdgeInsets.symmetric(horizontal: 25),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  InputDecoration inputTime(label) {
    return InputDecoration(
        focusColor: Colors.black,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        floatingLabelStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        label: Text(label));
  }

  static BoxDecoration categorysHome = BoxDecoration(
    border: Border.all(width: 1, color: Colors.white),
  );

  static BoxDecoration containerRegister = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    color: Colors.white,
    border: Border.all(
      width: 1,
      color: Colors.white,
    ),
  );

  static BoxDecoration containerPlanes = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    border: Border.all(width: 1, color: Colors.white),
  );

  InputDecoration inputHomeSearch(label, BuildContext context) {
    return InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        floatingLabelStyle: const TextStyle(color: Colors.white),
        suffixIcon: InkWell(
          onTap: () {
                                                  context.vRouter.to(
                                                      '/search');
          },
          child: const Icon(Icons.search)),
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? Colors.white
                : Colors.grey),
        label: Text(label));
  }
}
