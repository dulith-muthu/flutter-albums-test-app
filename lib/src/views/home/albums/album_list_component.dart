import 'package:albums/src/models/api/album.dart';
import 'package:albums/src/services/api/albums_service.dart';
import 'package:albums/src/views/home/albums/album_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumsListComponent extends StatefulWidget {
  const AlbumsListComponent({super.key});

  @override
  State<AlbumsListComponent> createState() => _AlbumsListComponentState();
}

class _AlbumsListComponentState extends State<AlbumsListComponent> {
  late Future<List<Album>> _albums;

  @override
  void initState() {
    final albumApiService = context.read<AlbumsApiService>();
    _albums = albumApiService.fetchAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
        future: _albums,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget.withDetails(message: snapshot.error.toString());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListView(
                  children: snapshot.data!
                      .map((album) => AlbumComponent(album: album))
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
