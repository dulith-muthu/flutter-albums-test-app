import 'dart:convert';

import 'package:albums/src/models/api/album.dart';
import 'package:albums/src/models/api/photo.dart';
import 'package:albums/src/services/api/_api_helper.dart';
import 'package:albums/src/services/user_service.dart';
import 'package:http/http.dart' as http;

class AlbumsApiService {
  const AlbumsApiService(this._user);

  final UserService _user;

  Future<Album> fetchAlbum(int id) async {
    final uri = ApiHelper.buildUri(path: "albums/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw 'Failed to load album: $id';
    }
  }

  Future<List<Album>> fetchAlbums() async {
    final uri = ApiHelper.buildUri(path: "albums", userId: _user.userId);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List parsedList = jsonDecode(response.body);
      return parsedList.map((e) => Album.fromJson(e)).toList();
    } else {
      throw 'Failed to load albums';
    }
  }

  Future<List<Photo>> fetchAlbumPhotos(int id) async {
    final uri = ApiHelper.buildUri(path: "albums/$id/photos");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List parsedList = jsonDecode(response.body);
      return parsedList.map((e) => Photo.fromJson(e)).toList();
    } else {
      throw 'Failed to load photos';
    }
  }
}
