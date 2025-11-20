import 'dart:developer';

import 'package:flutter/material.dart';

class SelectCurrentContentProvider with ChangeNotifier {
  int currentContent = 0;

  void selectCurrentContent({
    required int selectedIndex,
  }) {
    currentContent = selectedIndex;
    log("Current index : $selectedIndex");
    notifyListeners();
  }

  void get setFirstContent {
    currentContent = 0;
    notifyListeners();
  }
}
