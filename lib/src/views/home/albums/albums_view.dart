import 'package:albums/src/models/Api/album.dart';
import 'package:albums/src/services/api/albums_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumsView extends StatefulWidget {
  const AlbumsView({super.key});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
        future: _getData(context),
        initialData: null,
        builder:
            (BuildContext context, AsyncSnapshot<List<Album>> albumsAsync) {
          return ListView(
              children: albumsAsync.data != null
                  ? albumsAsync.data!
                      .map((album) => Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            color: Theme.of(context).hoverColor,
                            child: ListTile(
                              title: Text(
                                "${album.id}",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              subtitle: Text(album.title),
                              onTap: () {},
                            ),
                          ))
                      .toList()
                  : [
                      const Padding(
                        padding: EdgeInsets.all(30),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ]);
        });
  }

  Future<List<Album>> _getData(BuildContext context) async {
    final albumApiService = context.read<AlbumsApiService>();
    return await albumApiService.fetchAlbums();
  }
}
