import 'package:flutter/material.dart';

class AppShadows {
  static const ombre02 = BoxShadow(
    color: Color(0x1a000000),
    offset: Offset(0, -5),
    blurRadius: 10,
    spreadRadius: 0,
  );

  static const ombre01 = BoxShadow(
    color: Color(0x1a000000),
    offset: Offset(0, 3),
    blurRadius: 10,
    spreadRadius: 0,
  );

  AppShadows._();
}
