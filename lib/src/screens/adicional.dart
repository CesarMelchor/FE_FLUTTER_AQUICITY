import 'dart:convert';

import 'package:aquicity/src/utils/api_calls.dart';
import 'package:aquicity/src/utils/messages.dart';
import 'package:aquicity/src/utils/styles.dart';
import 'package:aquicity/src/widgets/appbar_business.dart';
import 'package:aquicity/src/widgets/drawer_business.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:cooky/cooky.dart' as cookie;

class AdicionalScreen extends StatefulWidget {
  const AdicionalScreen({super.key});

  @override
  State<AdicionalScreen> createState() => _AdicionalScreenState();
}

class _AdicionalScreenState extends State<AdicionalScreen> {
  TextEditingController informacion = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  TextEditingController estado = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController hora1 = TextEditingController();
  TextEditingController hora2 = TextEditingController();
  TextEditingController hora3 = TextEditingController();
  TextEditingController hora4 = TextEditingController();
  TextEditingController hora5 = TextEditingController();
  TextEditingController hora6 = TextEditingController();
  TextEditingController hora7 = TextEditingController();
  TextEditingController hora8 = TextEditingController();
  TextEditingController hora9 = TextEditingController();
  TextEditingController hora10 = TextEditingController();
  TextEditingController hora11 = TextEditingController();
  TextEditingController hora12 = TextEditingController();
  TextEditingController hora13 = TextEditingController();
  TextEditingController hora14 = TextEditingController();

  TextEditingController hora15 = TextEditingController();
  TextEditingController hora16 = TextEditingController();
  TextEditingController hora17 = TextEditingController();
  TextEditingController hora18 = TextEditingController();
  TextEditingController hora19 = TextEditingController();
  TextEditingController hora20 = TextEditingController();
  TextEditingController hora21 = TextEditingController();
  TextEditingController hora22 = TextEditingController();
  TextEditingController hora23 = TextEditingController();
  TextEditingController hora24 = TextEditingController();
  TextEditingController hora25 = TextEditingController();
  TextEditingController hora26 = TextEditingController();
  TextEditingController hora27 = TextEditingController();
  TextEditingController hora28 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Response response;
  Dio dio = Dio();
  late List<String> list1;
  var horario = "";

  Future obtainDataAd(BuildContext context) async {
    var idsend = cookie.get('id');

    response =
        await dio.get('https://aqui.city/api/public/v1/ad/detail/$idsend');

    informacion.text = response.data[0]['descripcion_adicional'];

    horario = response.data[0]['horarios'];
    list1 = horario.split("<");

    hora1.text = list1[0];
    hora2.text = list1[1];
    hora3.text = list1[2];
    hora4.text = list1[3];
    hora5.text = list1[4];
    hora6.text = list1[5];
    hora7.text = list1[6];
    hora8.text = list1[7];
    hora9.text = list1[8];
    hora10.text = list1[9];
    hora11.text = list1[10];
    hora12.text = list1[11];
    hora13.text = list1[12];
    hora14.text = list1[13];

    hora15.text = list1[14];
    hora16.text = list1[15];
    hora17.text = list1[16];
    hora18.text = list1[17];
    hora19.text = list1[18];
    hora20.text = list1[19];
    hora21.text = list1[20];
    hora22.text = list1[21];
    hora23.text = list1[22];
    hora24.text = list1[23];
    hora25.text = list1[24];
    hora26.text = list1[25];
    hora27.text = list1[26];
    hora28.text = list1[27];

    return response.data;
  }

  late final Future myFuture = obtainDataAd(context);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool responsive = false;
    if (size.width <= 844) {
      responsive = true;
    } else {
      responsive = false;
    }

    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Form(
                key: _formKey,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 214, 85, 76),
                    title: const AppbarBusiness(),
                  ),
                  drawer: const DrawerBussiness(),
                  body: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          Text(
                            "HORARIOS",
                            style: TextStyle(fontSize: Adaptive.sp(14)),
                          ),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                          responsive == true
                              ? Column(
                                  children: [
                                    SizedBox(
                                      width: Adaptive.w(2),
                                    ),
                                    Row(
                                      children: [
                                        // lunes
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "LUNES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora1,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora2,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora3,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora4,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        // martes
                                        Column(
                                          children: [
                                            Text(
                                              "MARTES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora5,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora6,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora7,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora8,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // MIERCOLES
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "MIERCOLES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora9,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora10,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora11,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora12,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        // JUEVES
                                        Column(
                                          children: [
                                            Text(
                                              "JUEVES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora13,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora14,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora15,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora16,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // VIERNES
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "VIERNES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora17,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora18,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora19,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora20,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        // SABADO
                                        Column(
                                          children: [
                                            Text(
                                              "SABADO",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora21,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora22,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora23,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora24,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // DOMINGO
                                        SizedBox(
                                          width: Adaptive.w(5),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "DOMINGO",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(15)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora25,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora26,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora27,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(20),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora28,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              :
// web
                              Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "LUNES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora1,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora2,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora3,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora4,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "MARTES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora5,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora6,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora7,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora8,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "MIERCOLES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora9,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora10,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora11,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora12,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "JUEVES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora13,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora14,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora15,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora16,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "VIERNES",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora17,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora18,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora19,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora20,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "SABADO",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora21,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora22,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora23,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora24,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "DOMINGO",
                                              style: TextStyle(
                                                  fontSize: Adaptive.sp(13)),
                                            ),
                                            SizedBox(
                                              height: Adaptive.h(2),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora25,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora26,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora27,
                                                    decoration: Styles()
                                                        .inputTime("APERTURA"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(1),
                                                ),
                                                SizedBox(
                                                  width: Adaptive.w(8),
                                                  height: Adaptive.h(10),
                                                  child: DateTimeField(
                                                    controller: hora28,
                                                    decoration: Styles()
                                                        .inputTime("CIERRE"),
                                                    format: DateFormat("HH:mm"),
                                                    onShowPicker: (context,
                                                        currentValue) async {
                                                      final time =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                currentValue ??
                                                                    DateTime
                                                                        .now()),
                                                      );
                                                      return DateTimeField
                                                          .convert(time);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Adaptive.w(2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                var dataUpdate = jsonEncode({
                                  "horarios":
                                      "${hora1.text}<${hora2.text}<${hora3.text}<${hora4.text}<${hora5.text}<${hora6.text}<${hora7.text}<${hora8.text}<${hora9.text}<${hora10.text}<${hora11.text}<${hora12.text}<${hora13.text}<${hora14.text}${hora15.text}<${hora16.text}<${hora17.text}<${hora18.text}<${hora19.text}<${hora20.text}<${hora21.text}<${hora22.text}<${hora23.text}<${hora24.text}<${hora25.text}<${hora26.text}<${hora27.text}<${hora28.text}",
                                });
                                if (await ApiCalls()
                                    .updateDataAd(dataUpdate, context)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Información actualizada', context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Ocurrió un error, intentalo de nuevo más tarde.',
                                      context);
                                }
                              },
                              child: const Text("GUARDAR")),
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          const Divider(),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          Text("INFORMACION ADICIONAL",
                              style: TextStyle(fontSize: Adaptive.sp(14))),
                          SizedBox(
                            height: Adaptive.h(4),
                          ),
                          SizedBox(
                            width: Adaptive.w(95),
                            child: TextFormField(
                              controller: informacion,
                              onChanged: (value) {},
                              decoration: Styles().inputStyle1("INFORMACION"),
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
                          OutlinedButton(
                              onPressed: () async {
                                var dataUpdate = jsonEncode({
                                  "descripcion_adicional": informacion.text,
                                });
                                if (await ApiCalls()
                                    .updateDataAd(dataUpdate, context)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Información actualizada', context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Ocurrió un error, intentalo de nuevo más tarde.',
                                      context);
                                }
                              },
                              child: const Text("GUARDAR")),
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          const Divider(),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          Text("NUEVA SUCURSAL",
                              style: TextStyle(fontSize: Adaptive.sp(14))),
                          SizedBox(
                            height: Adaptive.h(4),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                width: Adaptive.w(30),
                                child: TextFormField(
                                  controller: nombre,
                                  onChanged: (value) {},
                                  decoration: Styles().inputStyle1("SUCURSAL"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo no puede estar vacío";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: Adaptive.w(1),
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
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                width: Adaptive.w(30),
                                child: TextFormField(
                                  controller: telefono,
                                  maxLength: 10,
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
                            ],
                          ),
                          SizedBox(
                            height: Adaptive.h(4),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                width: Adaptive.w(30),
                                child: TextFormField(
                                  controller: ciudad,
                                  onChanged: (value) {},
                                  decoration: Styles().inputStyle1("CIUDAD"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo no puede estar vacío";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                width: Adaptive.w(30),
                                child: TextFormField(
                                  controller: estado,
                                  onChanged: (value) {},
                                  decoration: Styles().inputStyle1("ESTADO"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo no puede estar vacío";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                width: Adaptive.w(30),
                                child: TextFormField(
                                  controller: direccion,
                                  onChanged: (value) {},
                                  decoration: Styles().inputStyle1("DIRECCION"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo no puede estar vacío";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Adaptive.h(3),
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                var sucursal = jsonEncode({
                                  "nombre_suscursal": nombre.text,
                                  "email": correo.text,
                                  "telefono": telefono.text,
                                  "cuidad": ciudad.text,
                                  "estado": estado.text,
                                  "direccion": direccion.text,
                                  "user_id": cookie.get('id'),
                                });
                                if (await ApiCalls()
                                    .createSucursal(sucursal, context)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Sucursal creada', context);
                                  nombre.text = "";
                                  correo.text = "";
                                  telefono.text = "";
                                  ciudad.text = "";
                                  estado.text = "";
                                  direccion.text = "";
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Ocurrió un error, intentalo de nuevo más tarde.',
                                      context);
                                }
                              },
                              child: const Text("GUARDAR")),
                          SizedBox(
                            height: Adaptive.h(3),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
