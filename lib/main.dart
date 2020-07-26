import 'dart:io';

import 'package:flutter/material.dart';
import 'api/categories_api.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context) {
    // TODO: implement createHttpClient
    return new HttpClient(context: context)
        ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  }
}

void main(){
    runApp(bipinNewsApp());
}


// ignore: camel_case_types
class bipinNewsApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,

      ),
      home:HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoiresApi categoiresApi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoiresApi = CategoiresApi();
    categoiresApi.fetchAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BipiNews App'),
      ),
      body: Center(
        child: Text('Hello Flutter'),
      ),
    );
  }
}
