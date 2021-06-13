import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:sporto/utils/commons.dart';
import 'package:sporto/views/description-page/description-page.dart';

import '../../models/shop.dart';
import '../../utils/commons.dart';
import 'prefered-shop.dart';
import 'shop-list-widget.dart';
import 'shop.provider.dart';

class ShopListPage extends StatefulWidget {
  const ShopListPage({Key key}) : super(key: key);

  @override
  _ShopListPage createState() => _ShopListPage();
}

class _ShopListPage extends State<ShopListPage> {
  ShopProvider _shopProvider;
  Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('shops').snapshots();

  @override
  void initState() {
    _shopProvider = Provider.of<ShopProvider>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _shopProvider.getLocations());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget loading() {
    return Column(
      children: <Widget>[
        const PlayStoreShimmer(),
        const ListTileShimmer(),
        const ListTileShimmer(),
        const ListTileShimmer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _shopProvider = Provider.of<ShopProvider>(context);
    return _shopProvider.isLoading ? loading() : sample();
  }

  Widget sample() {
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('>>>>>>>>>>>>>>>>>>>>>>> error : ${snapshot.error}');
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        }

        return SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(
                  'Select Location',
                  style: TextStyle(
                      // color: Commons.bgColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              _categoryField(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Text(
                  'Most Preferred',
                  style: TextStyle(
                      // color: Commons.bgColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              SingleChildScrollView(
                child: Wrap(
                  children: [
                    PreferredShop(),
                    if (snapshot.data.size == 0 || snapshot.data.size == null)
                      const Center(
                          child: Text('No Shop Available in this Area'))
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.size ?? 0,
                            itemBuilder: (context, index) {
                              print(snapshot.data.docs[index].data());
                              if (_shopProvider.selectedLoaction == 'any' ||
                                  _shopProvider.selectedLoaction ==
                                      snapshot.data.docs[index].data()['area'])
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DescriptionPage(
                                                shopDetails:
                                                    ShopDetails.fromJson(
                                                        snapshot
                                                            .data.docs[index]
                                                            .data()),
                                              )),
                                    );
                                  },
                                  child: SalonCard(
                                      shopDetails: ShopDetails.fromJson(
                                          snapshot.data.docs[index].data())),
                                );
                              return Container();
                            }),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _categoryField() {
    return ListTile(
      leading: Icon(
        Icons.my_location,
        color: Colors.black,
      ),
      title: DropdownButton<String>(
        focusColor: Colors.white,
        value: _shopProvider.selectedLoaction,
        onChanged: (String value) =>
            _shopProvider.changeSelectedLoaction(value),
        hint: Text(
          'Location',
          textAlign: TextAlign.center,
          style: TextStyle(color: Commons.greyAccent2),
        ),
        items: _shopProvider.locations.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              '$item',
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}
