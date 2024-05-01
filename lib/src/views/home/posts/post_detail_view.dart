import 'package:albums/src/models/api/comment.dart';
import 'package:albums/src/models/api/post.dart';
import 'package:albums/src/services/api/posts_api_service.dart';
import 'package:albums/src/views/home/posts/comment_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailView extends StatefulWidget {
  const PostDetailView({super.key, required Post post}) : _post = post;

  static const routeName = '/post';
  final Post _post;

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    final postsApiService = context.read<PostsApiService>();
    _comments = postsApiService.fetchPostComments(widget._post.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._post.title),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: _comments,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorWidget.withDetails(
                      message: snapshot.error.toString());
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data!
                              .map((comment) =>
                                  CommentComponent(comment: comment))
                              .toList()),
                    ));
                  default:
                    return const Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    );
                }
              },
            )
          ],
        ));
  }
}
