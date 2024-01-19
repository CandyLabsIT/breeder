import 'package:breeder/views/pages/main_menu_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFEAC5),
          ),
          child: const MainMenu(),
        ),
      ),
    ),
  );
}
