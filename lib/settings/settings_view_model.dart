import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsViewModel());

class SettingsViewModel extends ChangeNotifier {
  double tileSize = 100.0;
  double lineWidth = 5.0;

  double borderRadius = 50.0;

  void setLineWidth(double lineWidth) {
    this.lineWidth = lineWidth;
    notifyListeners();
  }

  void setBorderRadius(double borderRadius) {
    this.borderRadius = borderRadius;
    notifyListeners();
  }

  SettingsViewModel();
}
