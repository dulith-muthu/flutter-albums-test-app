import 'package:albums/src/models/login_user.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  LoginUser? _loggedUser;
  
  void setLoggedUser(LoginUser? user) {
    _loggedUser = user;
    notifyListeners();
  }

  bool isAuthenticated() {
    return _loggedUser != null;
  }

  int get userId => _loggedUser != null ? _loggedUser!.userId : 0;
  String get name => _loggedUser != null ? _loggedUser!.name : "";
  String get username => _loggedUser != null ? _loggedUser!.username : "";
  String get token => _loggedUser != null ? _loggedUser!.token : "";
}