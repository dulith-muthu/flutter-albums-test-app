import 'dart:convert';

import 'package:albums/src/models/api/post.dart';
import 'package:albums/src/models/api/comment.dart';
import 'package:albums/src/services/api/_api_helper.dart';
import 'package:albums/src/services/user_service.dart';
import 'package:http/http.dart' as http;

class PostsApiService {
  const PostsApiService(this._user);

  final UserService _user;

  Future<Post> fetchPost(int id) async {
    final uri = ApiHelper.buildUri(path: "post/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw 'Failed to load post: $id';
    }
  }

  Future<List<Post>> fetchPosts() async {
    final uri = ApiHelper.buildUri(path: "posts", userId: _user.userId);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List parsedList = jsonDecode(response.body);
      return parsedList.map((e) => Post.fromJson(e)).toList();
    } else {
      throw 'Failed to load posts';
    }
  }

  Future<List<Comment>> fetchPostComments(int id) async {
    final uri = ApiHelper.buildUri(path: "posts/$id/comments");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List parsedList = jsonDecode(response.body);
      return parsedList.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw 'Failed to load comments for post id: $id';
    }
  }
}
