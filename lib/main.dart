import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'api/categories_api.dart';
import 'screens/category_posts.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoiresApi categoiresApi = CategoiresApi();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BipiNews App'),
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: FutureBuilder(
            future: categoiresApi.fetchAllCategories(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  //still working
                  return _loading();
                  break;

                case ConnectionState.waiting:
                  // still waiting
                  return _loading();
                  break;

                case ConnectionState.none:
                  // error
                  return _error('No connection has been made!');
                  break;

                case ConnectionState.done:
                  //completed
                  if (snapshot.hasError) {
                    return _error(snapshot.error.toString());
                  }
                  if (snapshot.hasData) {
                    return _drawCategoriesList(snapshot.data, context);
                  }
                  break;
              }
              return Container();
            },
          ),
        ));
  }

  Widget _drawCategoriesList(List<Category> categories, BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int position) {
        return InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(categories[position].title),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CateogryPosts(categories[position].id)));
          },
        );
      },
    );
  }

  Widget _error(String error) {
    return Container(
        child: Center(
      child: Text('Error!', style: TextStyle(color: Colors.red)),
    ));
  }

  Widget _loading() {
    return Container(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
