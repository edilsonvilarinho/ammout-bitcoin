import 'package:bitcoin/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Color(0xFFF7931B),
      backgroundColor: Color(0xFFE1E1E1), // 0xFF
    ),
    home: Home(),
  ));
}
