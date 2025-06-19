import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_6/meet_6.dart';
import 'package:ppkd_b2/TUgas/theme_provider.dart';
import 'package:ppkd_b2/meet_12/meet_12a.dart';
import 'package:ppkd_b2/meet_12/meet_12c.dart';
import 'package:ppkd_b2/meet_16/login_screen.dart';
import 'package:ppkd_b2/meet_16/register_screen.dart';
import 'package:ppkd_b2/splash_screen.dart';
import 'package:ppkd_b2/study_2/screens/hewan_form.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      initialRoute: "/",
      routes: {
        //Harus didaftarkan dulu disini
        "/": (context) => SplashScreen(),
        "/login": (context) => Meet6(),
        "/meet_12c": (context) => MeetDuaBelasC(),
        // "/meet_2": (context) => MeetDua(),
        LoginScreenApp.id: (context) => LoginScreenApp(),
        Meet12AInputWidget.id: (context) => Meet12AInputWidget(),
        RegisterScreenApp.id: (context) => RegisterScreenApp(),
        HewanFormScreen.routeName: (context) => const HewanFormScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(color: Colors.black),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // home: SplashScreen(),
    );
  }
}
