import 'package:albums/src/login/login_credentials.dart';

abstract class AuthService {
  Future<bool> login(LoginCredentials credentials);
  Future<bool> logout();
}
