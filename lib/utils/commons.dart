import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:rxdart/rxdart.dart';

class Commons {
  // static BehaviorSubject<Event> events = BehaviorSubject<Event>();
  static const baseURL = 'https://doofie.herokuapp.com/api_v1';

  static const newsAPIKey = '9a9ac82d4fac47a5ab6e37138c5b86ad';

  static const hintColor = Color(0xFF4D0F29);
  static Color bgColor = Commons.colorFromHex('#66ccff');
  static Color bgLightColor = Commons.colorFromHex('#e6f7ff');

  static Color greyAccent1 = Commons.colorFromHex('#f7f7f7');
  static Color greyAccent2 = Commons.colorFromHex('#cccccc');
  static Color greyAccent3 = Commons.colorFromHex('#999999');
  static Color greyAccent4 = Commons.colorFromHex('#8e8e93');
  static Color greyAccent5 = Commons.colorFromHex('#333333');

  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // static Widget loader() {
  //   return SpinKitFadingCircle(color: Colors.black);
  // }
}

class Event {
  String name;
  var extra;
  Event({@required this.name, this.extra});
}

const String RELOAD_MENU = 'RELOAD_MENU';
