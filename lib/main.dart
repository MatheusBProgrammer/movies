import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/utils/routes.dart';

import 'description.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,primaryColor: Colors.green),
        initialRoute: '/',
      routes: {
        AppRoutes.HOME:(_) => HomePage(),
      },
    );
  }
}
