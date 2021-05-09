import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/commons.dart';
import '../about/about.dart';
import '../news/news-page.dart';
import '../shop-list/shop-list.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    ShopListPage(),
    NewsPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Commons.appBar,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        elevation: 5,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 18,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 25,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito'),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.map_outlined,
              size: 18,
            ),
            activeIcon: Icon(
              Icons.map,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              'Trending News',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito'),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.face_unlock_rounded,
              size: 18,
            ),
            activeIcon: Icon(
              Icons.face_unlock_rounded,
              color: Colors.white,
              size: 25,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Nunito'),
            ),
          ),
        ],
      ),
    );
  }
}
