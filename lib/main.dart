import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash-screen.dart';
import 'utils/app-theme.dart';
import 'views/about/add-shop.form.dart';
import 'views/about/admin.dart';
import 'views/about/login.dart';
import 'views/dashboard/dashboard.dart';
import 'views/description-page/description-page.dart';
import 'views/news/news-services.dart';
import 'views/shop-list/shop-list.dart';
import 'views/shop-list/shop.provider.dart';

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
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/dashboard': (BuildContext context) => Dashboard(),
            '/shops': (BuildContext context) => ShopListPage(),
            '/descriptionPage': (BuildContext context) => DescriptionPage(),
            '/login': (BuildContext context) => LoginPage(),
            '/admin': (BuildContext context) => AdminPage(),
            '/add-shop': (BuildContext context) => AddShop(),
            '/add-preferred-shop': (BuildContext context) =>
                AddShop(prefrerred: true),
          }),
    );
  }
}
