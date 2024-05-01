import 'package:albums/src/models/api/album.dart';
import 'package:albums/src/views/home/albums/album_detail_view.dart';
import 'package:flutter/material.dart';

class AlbumComponent extends StatelessWidget {
  const AlbumComponent({super.key, required Album album, this.clickable = true})
      : _album = album;
  final Album _album;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      color: Theme.of(context).hoverColor,
      child: ListTile(
        title: Text(
          "${_album.id}",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        subtitle: Text(_album.title),
        onTap: clickable
            ? () {
                Navigator.pushNamed(
                    context, AlbumDetailView.routeName,
                    arguments: _album);
              }
            : null,
      ),
    );
  }
}
