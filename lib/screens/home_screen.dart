import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_util.dart';
import 'package:flutter_app/api/posts_api.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/shared_ui/post_lists.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PostsApi postsApi = PostsApi();
  List<Post> postWithImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text('Header'),
            ),
            ListTile(
              title: Text('Categories'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/categories');
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: postsApi.fetchRecentPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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
              if (!snapshot.hasData) {
                return _error('No data fetched yet!');
              }
              return _drawHomeScreen(snapshot.data);
              break;
          }
          return Container();
        },
      ),
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

  Widget _drawHomeScreen(List<Post> posts) {
    for (Post post in posts) {
      if (post.images.length > 0) {
        var newString = post.images[0].image_url;
        post.images[0].image_url = newString.replaceAll('public', 'uploads');
        postWithImages.add(post);
      }
    }
    return Column(
      children: <Widget>[
        _slider(postWithImages),
        _postList(posts),
      ],
    );
  }

  Widget _slider(List<Post> posts) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: PageView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position) {
          return InkWell(
            onTap: () {},
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(ApiUtil.MAIN_APP_URL +
                        posts[position].images[0].image_url),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 8),
                        color: Colors.grey.withAlpha(100),
                        child: Text(posts[position].post_title,
                            style: TextStyle(fontSize: 18)))),
              ],
            ),
          );
        },
      ),
    );
  }

  _postList(List<Post> posts) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int position) {
            return PostCard(posts[position]);
          },
        ),
      ),
    );
  }
}
