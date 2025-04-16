import 'package:flutter/material.dart';

// OS System Settings
bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

// App Theme Settings
// bool isDarkMode(BuildContext context) =>
//     Theme.of(context).brightness == Brightness.dark;
