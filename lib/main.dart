import 'package:DexPal/dexViewPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'DexPal',
      theme: ThemeData(
        //fontFamily: GoogleFonts.comfortaa(),
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
      ),
      home: const DexPage(),
      routes: const {},
    ),
  );
}
