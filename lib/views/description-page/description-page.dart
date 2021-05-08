import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sporto/utils/commons.dart';

class DescriptionPage extends StatefulWidget {
  final String address;
  final String name;
  final String phone;
  final String sportsOffered;
  final String description;
  final String imgUrl;

  const DescriptionPage(
      {this.address,
      this.name,
      this.phone,
      this.sportsOffered,
      this.description,
      this.imgUrl});

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              )),
          title: Text(
            'Description',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Commons.bgLightColor),
                    child: (widget.imgUrl == null || widget.imgUrl == '')
                        ? Image.asset(
                            'assets/images/shop-bg.png',
                            color: Commons.greyAccent3,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.imgUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                  if (widget.imgUrl != null && widget.imgUrl != '')
                    Container(
                      height: 240,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(.3),
                    ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      widget.name ?? 'Shop Name',
                      style: TextStyle(
                          color: (widget.imgUrl != null && widget.imgUrl != '')
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Commons.bgColor,
                thickness: 1,
                height: 0,
              ),
              textField(
                context,
                title: 'About',
                value: widget.description ??
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
              ),
              textField(context,
                  title: 'Sports Offered',
                  value: widget.sportsOffered ?? 'details not available'),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Contact',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: ListTile(
                  leading: Icon(
                    Icons.call_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  title: Text(
                    widget.phone ?? 'Number not available',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: ListTile(
                  leading: Icon(
                    Icons.my_location_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  title: Text(
                    widget.address ?? 'Address',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(BuildContext context, {String title, String value}) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          child: Text(
            title ?? '',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Text(
            value ?? '',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
