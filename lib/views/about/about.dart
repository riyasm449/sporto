import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../utils/commons.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String data =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commons.bgColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                Text(
                  data,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                Divider(
                  color: Commons.greyAccent3,
                ),
                Text(
                  'Developed by',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Jayanth S (920218104011)',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Srinivas M (920218104038)',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                ),
                Divider(
                  color: Commons.greyAccent3,
                ),
                ListTile(
                  onTap: () async {
                    await Navigator.pushNamed(context, '/login');
                  },
                  title: Text(
                    'ADMIN LOGIN >>',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
