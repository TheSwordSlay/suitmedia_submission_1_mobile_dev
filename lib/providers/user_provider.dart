import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_submission/models/user.dart';
import 'package:suitmedia_submission/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final int _limit = 10;
  int _page = 1;
  bool hasMore = true;
  List<User> users = [];

  String _currentUser = "";
  String get currentUser => _currentUser;

  String _selectedUser = "";
  String get selectedUser => _selectedUser;

  void setCurrentUser(String name) {
    _currentUser = name;
    notifyListeners();
  }

  void setSelectedUser(String name) {
    _selectedUser = name;
    notifyListeners();
  }

  Future getUserList() async{
    try {
      List<User> response = await _userRepository.fetchUser(_page, _limit);

      if(response.length < _limit) {
        hasMore = false;
      }

      users.addAll(response);
      _page++;

      notifyListeners();
    // ignore: empty_catches
    } catch(e) {
      
    }
  }

  Future refresh() async {
    _page = 1;
    hasMore = true;
    users = [];

    await getUserList();
    notifyListeners();
  }
}