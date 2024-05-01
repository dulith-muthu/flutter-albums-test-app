import 'package:albums/src/models/api/album.dart';
import 'package:albums/src/models/api/photo.dart';
import 'package:albums/src/services/api/albums_service.dart';
import 'package:albums/src/views/home/albums/photo_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumDetailView extends StatefulWidget {
  const AlbumDetailView({super.key, required Album album}) : _album = album;

  static const routeName = '/album';
  final Album _album;

  @override
  State<AlbumDetailView> createState() => _AlbumDetailViewState();
}

class _AlbumDetailViewState extends State<AlbumDetailView> {
  late Future<List<Photo>> _photos;

  @override
  void initState() {
    final albumApiService = context.read<AlbumsApiService>();
    _photos = albumApiService.fetchAlbumPhotos(widget._album.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._album.title),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: _photos,
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
                      child: GridView.count(
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          children: snapshot.data!
                              .map((photo) => PhotoComponent(photo: photo))
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
