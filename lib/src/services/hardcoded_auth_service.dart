import 'package:albums/src/login/login_credentials.dart';
import 'package:albums/src/login/login_user.dart';
import 'package:albums/src/services/auth_service.dart';
import 'package:albums/src/services/user_service.dart';

class HardCodedAuthService implements AuthService {
  const HardCodedAuthService(this.userService);

  final UserService userService;

  @override
  Future<bool> login(LoginCredentials credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    if (credentials.username != 'admin' || credentials.password != 'admin') {
      throw Exception('Invalid Credentials');
    }
    const user = LoginUser(
        username: 'admin', firstName: 'Admin', lastName: 'User', token: 'test');
    userService.setLoggedUser(user);
    return true;
  }

  @override
  Future<bool> logout() async {
    userService.setLoggedUser(null);
    return true;
  }
}
