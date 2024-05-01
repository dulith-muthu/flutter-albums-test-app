import 'package:albums/src/services/user_service.dart';
import 'package:albums/src/views/home/albums/album_list_component.dart';
import 'package:albums/src/views/home/posts/post_list_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserService>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hi ${user.name}"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.album), text: "Albums"),
              Tab(icon: Icon(Icons.post_add), text: "Posts"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: AlbumsListComponent()),
            Center(child: PostListComponent()),
          ],
        ),
      ),
    );
  }
}
