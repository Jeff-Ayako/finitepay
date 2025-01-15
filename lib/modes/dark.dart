import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_flags/world_flags.dart';

ThemeData darkmode = ThemeData(
  textTheme: GoogleFonts.sofiaSansTextTheme(
    // Theme.of(Get.context!).textTheme,
  ),
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: const Color(0xff006316),
      ),
  extensions: const [
    FlagThemeData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  ],
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xff24292f),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey,
    indicatorColor: Colors.white,
    dividerColor: Colors.white,
  ),
  cardTheme: const CardTheme(
    color: Color(0xff24292f),
  ),
  scaffoldBackgroundColor: const Color(0xff0D1117),
  // scaffoldBackgroundColor: Colors.black,
  listTileTheme: const ListTileThemeData(
    textColor: Colors.white,
  ),
  // scaffoldBackgroundColor: const Color(0xff0d1117),
  primaryColor: const Color(0xff161b22),
  hintColor: Colors.grey,
  // textTheme: const TextTheme(
  //   titleLarge: TextStyle(
  //     color: Colors.white,
  //   ),
  //   titleSmall: TextStyle(
  //     color: Colors.white,
  //   ),
  //   titleMedium: TextStyle(
  //     color: Colors.white,
  //   ),
  //   bodySmall: TextStyle(
  //     color: Colors.white,
  //   ),
  //   bodyLarge: TextStyle(
  //     color: Colors.white,
  //   ),
  //   bodyMedium: TextStyle(
  //     color: Colors.white,
  //   ),
  // ),
);
