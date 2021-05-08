import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporto/utils/app-theme.dart';
import 'package:sporto/views/description-page/description-page.dart';
import 'package:sporto/views/shop-list/shop-list.dart';
import 'package:sporto/views/shop-list/shop.provider.dart';

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
        // ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => ShopProvider()),
        // ChangeNotifierProvider(create: (context) => AddressProvider()),
      ],
      child: MaterialApp(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          // home: DescriptionPage(),
          home: ShopListPage(),
          routes: <String, WidgetBuilder>{
            '/shops': (BuildContext context) => ShopListPage(),
            '/descriptionPage': (BuildContext context) => DescriptionPage(),
            // '/menu': (BuildContext context) => MenuPage(),
            // '/addressPage': (BuildContext context) => AddressPage(),
          }),
    );
  }
}
