import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelio_app/config/app.color.dart';
import 'package:hotelio_app/config/app.route.dart';
import 'package:hotelio_app/config/session.dart';
import 'package:hotelio_app/firebase_options.dart';
import 'package:hotelio_app/models/user_model.dart';
import 'package:hotelio_app/pages/checkout_page.dart';
import 'package:hotelio_app/pages/checkout_success_page.dart';
import 'package:hotelio_app/pages/detail_page.dart';
import 'package:hotelio_app/pages/intro_page.dart';
import 'package:hotelio_app/pages/sign_in_page.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting("en_US");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: AppColor.backgroundScaffold,
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
          )),
      routes: {
        '/': (context) {
          return FutureBuilder(
            future: Session.getUser(),
            builder: (context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.data == null || snapshot.data!.id == null) {
                return const IntroPage();
              } else {
                return HomePage();
              }
            },
          );
        },
        AppRoute.intro: (context) => const IntroPage(),
        AppRoute.home: (context) => HomePage(),
        AppRoute.signin: (context) => SignInPage(),
        AppRoute.detail: (context) => DetailPage(),
        AppRoute.checkout: (context) => CheckoutPage(),
        AppRoute.checkoutSuccess: (context) => CheckoutSuccessPage(),
        AppRoute.detailBooking: (context) => HomePage(),
      },
    );
  }
}
