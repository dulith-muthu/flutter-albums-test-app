import 'package:albums/src/models/api/post.dart';
import 'package:albums/src/views/home/posts/post_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({super.key, required Post post}) : _post = post;
  final Post _post;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _post.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _post.body,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, PostDetailView.routeName,
                        arguments: _post);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).canvasColor)),
                  label: Text(AppLocalizations.of(context)!.postComments),
                  icon: const Icon(Icons.comment),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
