import 'package:flutter/material.dart';
import 'package:ppkd_b2/Meet_6/meet_6.dart';
import 'package:ppkd_b2/TUgas/theme_provider.dart';
import 'package:ppkd_b2/meet_12/meet_12a.dart';
import 'package:ppkd_b2/meet_12/meet_12c.dart';
import 'package:ppkd_b2/meet_16/login_screen.dart';
import 'package:ppkd_b2/meet_16/register_screen.dart';
import 'package:ppkd_b2/study_2/screens/hewan_form.dart';
// PASTIKAN PATH INI BENAR: // Mengasumsikan ini nama kelasnya
import 'package:ppkd_b2/tugas_14/model/character_model.dart'; // <<< TAMBAHKAN INI untuk mengakses EnumValues
import 'package:ppkd_b2/tugas_15/model/Login_model.dart';
import 'package:ppkd_b2/tugas_15/view/auth/login.dart';
import 'package:ppkd_b2/tugas_15/view/auth/regist.dart';
import 'package:ppkd_b2/tugas_15/view/home_screen.dart';
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

  // Fungsi helper untuk mengonversi nilai enum menjadi String yang mudah dibaca.
  // Ini adalah fungsi yang dibutuhkan oleh FilteredCharacterListView.
  String? _getEnumValue(dynamic enumValue, EnumValues enumValues) {
    if (enumValue == null) {
      return null;
    }
    // Pastikan `reverse` ada di EnumValues Anda
    // dan tipenya Map<dynamic, String> atau Map<T, String>
    return enumValues.reverse[enumValue];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      initialRoute: "/",
      routes: {
        //Harus didaftarkan dulu disini
        // PERBAIKI BARIS INI: Tambahkan argumen required `getEnumValue`
        "/": (context) => loginScreenApi(),
        "/login": (context) => Meet6(),
        "/meet_12c": (context) => MeetDuaBelasC(),
        // "/meet_2": (context) => MeetDua(),
        LoginScreenApp.id: (context) => LoginScreenApp(),
        Meet12AInputWidget.id: (context) => Meet12AInputWidget(),
        RegisterScreenApp.id: (context) => RegisterScreenApp(),
        RegisterScreenAPI.id: (context) => RegisterScreenAPI(),
        loginScreenApi.id: (context) => loginScreenApi(),
        HomeScreen1.id: (context) => HomeScreen1(),
        HewanFormScreen.routeName: (context) => const HewanFormScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(color: Colors.black),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // home: SplashScreen(), // Anda menggunakan initialRoute, jadi home tidak diperlukan
    );
  }
}
