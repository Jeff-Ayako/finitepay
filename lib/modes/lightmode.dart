import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_flags/world_flags.dart';

ThemeData lightmode = ThemeData(
  textTheme: GoogleFonts.sofiaSansTextTheme(
      // Theme.of(Get.context!).textTheme,
      ),
  extensions: const [
    FlagThemeData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  ],
  // change the focus border color of the TextField

  colorScheme: ThemeData().colorScheme.copyWith(
        primary: const Color(0xFF5A31F4),
      ),
  useMaterial3: true,
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFF5A31F4),
    unselectedLabelColor: Colors.black,
    indicatorColor: Color(0xFF5A31F4),
    dividerColor: Color(0xFF5A31F4),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  hintColor: Colors.black,
  primaryColor: Colors.white,
  // textTheme: const TextTheme(
  //   bodyLarge: TextStyle(
  //     color: Colors.black,
  //   ),
  //   bodyMedium: TextStyle(
  //     color: Colors.black,
  //   ),
  // ),
);
