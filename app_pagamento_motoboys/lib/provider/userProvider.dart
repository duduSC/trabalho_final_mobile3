import 'package:app_pagamento_motoboys/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Userprovider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
