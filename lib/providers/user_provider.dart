import 'package:flutter/material.dart';
import 'package:shopsphere/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void logoutUser() {
    _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      type: '',
      token: '',
      cart: [],
    );
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
