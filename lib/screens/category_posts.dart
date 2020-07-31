import 'package:flutter/material.dart';
import 'package:flutter_app/api/categories_api.dart';
import 'package:flutter_app/models/post.dart';

class CateogryPosts extends StatefulWidget {
  final String categoryId;
  CateogryPosts(this.categoryId);



  @override
  _CateogryPostsState createState() => _CateogryPostsState();
}

class _CateogryPostsState extends State<CateogryPosts> {

  CategoiresApi categoiresApi = CategoiresApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),

      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: categoiresApi.fetchPostsforCategory(widget.categoryId),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.active:
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
                  return _drawPostsList(snapshot.data);
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }


  Widget _drawPostsList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int position) {
        return InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(posts[position].post_title),
            ),
          ),
          onTap: (){

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

