import 'dart:convert';

import 'package:albums/src/models/login_credentials.dart';
import 'package:albums/src/models/login_user.dart';
import 'package:albums/src/services/auth_service.dart';
import 'package:albums/src/services/user_service.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

final class _HardCodedCredential {
  const _HardCodedCredential(
      {required this.username, required this.password, required this.userId});
  final String username;
  final String password;
  final int userId;
}

class HardCodedAuthService implements IAuthService {
  const HardCodedAuthService(this._userService);

  static final _hardCodedCredentials = [
    for (int id in List.generate(10, (i) => i + 1, growable: false))
      _HardCodedCredential(username: "user$id", password: "user$id", userId: id)
  ];

  final UserService _userService;

  @override
  Future<bool> login(LoginCredentials credentials) async {
    final _HardCodedCredential? authenticated =
        _hardCodedCredentials.firstWhereOrNull((cred) =>
            cred.username == credentials.username &&
            cred.password == credentials.password);
    if (authenticated == null) {
      throw Exception('Invalid Credentials');
    }

    // replicating an authorize API call
    final response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/users/${authenticated.userId}"));
    final apiUser = jsonDecode(response.body) as Map<String, dynamic>;

    final user = LoginUser(
        userId: authenticated.userId,
        username: apiUser['username'],
        name: apiUser['name'],
        token: "test");
    _userService.setLoggedUser(user);
    return true;
  }

  @override
  Future<bool> logout() async {
    _userService.setLoggedUser(null);
    return true;
  }
}
