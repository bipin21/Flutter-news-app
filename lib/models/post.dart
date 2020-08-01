import 'package:flutter_app/models/author.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/post_comment.dart';
import 'package:flutter_app/models/post_image.dart';
import 'package:flutter_app/models/post_tag.dart';

class Post {
  String post_id, post_title, post_content, post_type, post_metadata;
  String updated_at;
  List<PostImage> images;
  Category category;
  Author author;
  List<PostTag> tags;
  List<PostComment> comments;

  Post(
      this.post_id,
      this.post_title,
      this.post_content,
      this.post_type,
      this.post_metadata,
      this.updated_at,
      this.images,
      this.category,
      this.author,
      this.tags,
      this.comments);

  Post.fromJson(Map<String, dynamic> jsonObject) {
    this.post_id = jsonObject['post_id'].toString();
    this.post_title = jsonObject['post_title'];
    this.post_content = jsonObject['post_content'];
    this.post_type = jsonObject['post_type'];

    this.updated_at = jsonObject['updated_at'].toString();

    this.category = Category.fromJson(jsonObject['category']);
    this.author = Author.fromJson(jsonObject['author']);

    this.images = [];
    for(var item in jsonObject['images']){
      images.add(PostImage.fromJson(item));
    }

    this.tags = [];
    for(var item in jsonObject['tags']){
      tags.add(PostTag.fromJson(item));
    }

    this.comments = [];
    for(var item in jsonObject['comments']){
      comments.add(PostComment.fromJson(item));
    }
  }

  String getFeaturedImage(){
    if(this.images.length > 0){
      return this.images[0].image_url;
    }
    return null;
  }

  String getAuthorFormattedName(){
  return '${this.author.first_name} ${this.author.last_name}';
  }

}
