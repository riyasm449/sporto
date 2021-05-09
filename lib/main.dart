import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporto/utils/app-theme.dart';
import 'package:sporto/views/about/admin.dart';
import 'package:sporto/views/about/login.dart';
import 'package:sporto/views/dashboard/dashboard.dart';
import 'package:sporto/views/description-page/description-page.dart';
import 'package:sporto/views/shop-list/shop-list.dart';
import 'package:sporto/views/shop-list/shop.provider.dart';

import 'views/news/news-services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShopProvider()),
        ChangeNotifierProvider(create: (context) => NewsProvider()),
      ],
      child: MaterialApp(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: Dashboard(),
          routes: <String, WidgetBuilder>{
            '/shops': (BuildContext context) => ShopListPage(),
            '/descriptionPage': (BuildContext context) => DescriptionPage(),
            '/login': (BuildContext context) => LoginPage(),
            '/admin': (BuildContext context) => AdminPage(),
          }),
    );
  }
}
