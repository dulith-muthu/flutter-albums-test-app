import 'package:albums/src/models/api/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class PhotoComponent extends StatelessWidget {
  const PhotoComponent({super.key, required Photo photo}) : _photo = photo;
  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    return BlurHash(
      image: _photo.thumbnailUrl,
      hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
      curve: Curves.easeIn,
      duration: Durations.short4,
    );
  }
}
