import 'package:flutter/material.dart';
import 'package:flutter_app/api/categories_api.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/screens/category_posts.dart';
import 'package:hex/hex.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {

  CategoiresApi categoiresApi = CategoiresApi();

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

        String hexColor =  categories[position].color.replaceAll('#', '0xFF');
        return Card (
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 2,
                  child: Container(
                    color: Color(int.parse(hexColor)),
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CateogryPosts(categories[position].id)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(categories[position].title,
                    style: TextStyle(
                      fontSize: 22,

                    ),
                  ),
                ),
              ),

            ],


          ),
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
