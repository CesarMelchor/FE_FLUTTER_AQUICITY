import 'package:aquicity/main_screen.dart';
import 'package:aquicity/src/providers/home_provider.dart';
import 'package:aquicity/src/providers/login_provider.dart';
import 'package:aquicity/src/providers/register_provider.dart';
import 'package:aquicity/src/screens/admin/anuncios_banner.dart';
import 'package:aquicity/src/screens/admin/banners_admin.dart';
import 'package:aquicity/src/screens/admin/dashboard_admin.dart';
import 'package:aquicity/src/screens/admin/login_admin.dart';
import 'package:aquicity/src/screens/data_ad.dart';
import 'package:aquicity/src/screens/data_posicionamiento.dart';
import 'package:aquicity/src/screens/detail_ad.dart';
import 'package:aquicity/src/screens/gallerys.dart';
import 'package:aquicity/src/screens/adicional.dart';
import 'package:aquicity/src/screens/login.dart';
import 'package:aquicity/src/screens/imagenes.dart';
import 'package:aquicity/src/screens/mapa.dart';
import 'package:aquicity/src/screens/planes.dart';
import 'package:aquicity/src/screens/register.dart';
import 'package:aquicity/src/screens/reset_pass.dart';
import 'package:aquicity/src/screens/data_property.dart';
import 'package:aquicity/src/screens/search.dart';
import 'package:aquicity/src/screens/videos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(ResponsiveSizer(builder: (context, orientation, screenType) {
    return VRouter(
      initialUrl: '/home',
      title: 'Aqui City',
      debugShowCheckedModeBanner: false,
      routes: [
        VWidget(
            path: '/home',
            widget: ChangeNotifierProvider(
                create: (_) => HomeProvider(),
                child: const MyHomePage(
                  title: '',
                ))),
        VWidget(
            path: '/planes',
            widget: ChangeNotifierProvider(
                create: (_) => RegisterProvider(),
                child: const PlanesScreen())),
        VWidget(
            path: '/detailAd/:id',
            widget: ChangeNotifierProvider(
                create: (_) => HomeProvider(), child: const DetailAdScreen())),
     
        VWidget(
            path: '/register',
            widget: ChangeNotifierProvider(
                create: (_) => RegisterProvider(),
                child: const RegisterScreen())),
        VWidget(
            path: '/login',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const LoginScreen())),
        VWidget(
            path: '/resetPassword',
            widget: ChangeNotifierProvider(
                create: (_) => RegisterProvider(),
                child: const ResetPasswordScreen())),
        VWidget(
            path: '/dataProperty',
            widget: ChangeNotifierProvider(
                create: (_) => RegisterProvider(),
                child: const DataPropertyScreen())),
        VWidget(
            path: '/dataAd',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const DataAdScreen())),
        VWidget(
            path: '/posicionamiento',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: const PosicionamientoScreen())),
        VWidget(
            path: '/mapa',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const MapaScreen())),
        VWidget(
            path: '/imagenes',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const ImagenesScreen())),
        VWidget(
            path: '/gallerys',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const GallerysScreen())),
        VWidget(
            path: '/videos',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const VideoScreen())),
        VWidget(
            path: '/adicional',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: const AdicionalScreen())),
        VWidget(
            path: '/admin',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: const LoginAdminScreen())),
        VWidget(
            path: '/dashboard',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(),
                child: const DashboardScreen())),
        VWidget(
            path: '/banners',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const BannersScreen())),
        VWidget(
            path: '/anuncios',
            widget: ChangeNotifierProvider(
                create: (_) => LoginProvider(), child: const AnunciosScreen())),
        VWidget(
            path: '/search',
            widget: ChangeNotifierProvider(
                create: (_) => HomeProvider(), child: const SearchScreen())),
      ],
    );
  }));
}
