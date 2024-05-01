import 'package:albums/src/models/login_credentials.dart';

abstract interface class IAuthService {
  Future<bool> login(LoginCredentials credentials);
  Future<bool> logout();
}
