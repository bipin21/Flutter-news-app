import 'dart:io';
import 'api_util.dart';
import 'package:flutter_app/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsApi{
  Future<List<Post>> fetchRecentPosts() async{
    String postUrl = ApiUtil.MAIN_API_URL + ApiUtil.RECENT_POSTS;

    Map<String, String> headers = {
      'Accept' : 'application/json'
    };
    
    var response = await http.get(postUrl, headers: headers);

    List<Post> posts  = [];
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);

      for(var item in body['data']){
        Post post = new Post.fromJson(item);
        posts.add(post);
      }

    }

    return posts;
  }
}