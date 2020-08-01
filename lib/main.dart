import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/screens/categories_list.dart';
import 'api/categories_api.dart';
import 'screens/category_posts.dart';
import 'screens/home_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    // TODO: implement createHttpClient
    return new HttpClient(context: context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  runApp(bipinNewsApp());
}

// ignore: camel_case_types
class bipinNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      routes: {
        '/': (BuildContext context) =>  HomeScreen(),
        '/categories': (BuildContext context) =>  CategoriesList(),
      },
    );
  }
}

//class HomeScreen extends StatefulWidget {
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  CategoiresApi categoiresApi = CategoiresApi();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//}
