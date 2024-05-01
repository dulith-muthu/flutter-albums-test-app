import 'package:albums/src/models/api/comment.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class CommentComponent extends StatelessWidget {
  const CommentComponent({super.key, required Comment comment})
      : _comment = comment;
  final Comment _comment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [RandomAvatar(_comment.email, height: 30, width: 30)],
        ),
        title: Text(_comment.name),
        subtitle: Text(_comment.body),
      ),
    );
  }
}
