import 'package:flutter/material.dart';

import 'commons.dart';

final appTheme = ThemeData(
  primaryColor: Commons.bgColor,
  primarySwatch: Colors.indigo,
  unselectedWidgetColor: Colors.white,
  accentIconTheme: IconThemeData(color: Commons.bgColor),
  textTheme: const TextTheme(bodyText1: TextStyle(fontFamily: 'Helvetica')),
  iconTheme: IconThemeData(color: Commons.bgColor),
  fontFamily: 'Helvetica',
  hintColor: Commons.hintColor,
);
