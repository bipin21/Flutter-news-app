import 'package:flutter/material.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/screens/singlepost.dart';

class PostCard extends StatelessWidget {
  Post post;

  // constructor
  PostCard(this.post);

  @override
  Widget build(BuildContext context) {

//    placeholder: 'assets/images/placeholde.png',
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: () {
            // single post screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePostScreen(post)));
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16),
                width: MediaQuery.of(context).size.width * 0.25,
                child: Image(
                  image: post.getPostImage(),
                  fit: BoxFit.cover,
                ),

              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.post_title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            post.getAuthorFormattedName(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            post.updated_at,
                            style: TextStyle(color: Colors.grey),
                          )
                        ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
