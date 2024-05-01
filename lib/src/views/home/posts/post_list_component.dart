import 'package:albums/src/models/api/post.dart';
import 'package:albums/src/services/api/posts_api_service.dart';
import 'package:albums/src/views/home/posts/post_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostListComponent extends StatefulWidget {
  const PostListComponent({super.key});

  @override
  State<PostListComponent> createState() => _PostListComponentState();
}

class _PostListComponentState extends State<PostListComponent> {
  late Future<List<Post>> _posts;

  @override
  void initState() {
    final postApiService = context.read<PostsApiService>();
    _posts = postApiService.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: _posts,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget.withDetails(message: snapshot.error.toString());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListView(
                  padding: const EdgeInsets.all(20),
                  children: snapshot.data!
                      .map((post) => PostComponent(post: post))
                      .toList());
            default:
              return const Padding(
                padding: EdgeInsets.all(30),
                child: Center(child: CircularProgressIndicator()),
              );
          }
        });
  }
}
