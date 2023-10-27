import 'package:flutter/material.dart';
class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndexFun(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}