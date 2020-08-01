import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/models/post_comment.dart';

class SinglePostScreen extends StatefulWidget {
  final Post post;

  SinglePostScreen(this.post);

  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.post.getPostImage(),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, position) {
              if (position == 0) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.post.post_content,
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );

              } else {
                // ignore: missing_return, missing_return
                for(var item in widget.post.comments){
                  return _commentsWidget(item);
                }
                return Container();

              }
            }, childCount: 2),
          )
        ],
      ),
    );
  }

  Widget _commentsWidget(PostComment comment) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(comment.comment,
              style: TextStyle(

              ),),
            Text(comment.author.getAuthorFormattedName(),
                style: TextStyle(

                )),
          ],
        ),
      ),

    );
  }


}
