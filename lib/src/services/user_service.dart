import 'package:albums/src/login/login_user.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  LoginUser? loggedUser;
  
  void setLoggedUser(LoginUser? user) {
    loggedUser = user;
    notifyListeners();
  }

  bool isAuthenticated() {
    return loggedUser != null;
  }
}