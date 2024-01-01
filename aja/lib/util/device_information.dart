import 'package:flutter/material.dart';

class DeviceInformation {
  static bool isTablet() =>
      (MediaQueryData.fromView(WidgetsBinding.instance.window))
          .size
          .shortestSide >=
      600;
}
