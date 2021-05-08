import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:sporto/utils/commons.dart';
import 'package:sporto/views/description-page/description-page.dart';
import 'package:sporto/views/news/news-services.dart';

import '../../models/shop.dart';
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
    return Scaffold(
      body: _shopProvider.isLoading ? loading() : sample(),
      backgroundColor: Commons.bgLightColor,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Sporto',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25),
        ),
      ),
    );
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
              GestureDetector(
                onTap: () async {
                  // SalonDetails _details = SalonDetails(
                  //   shopId: 'xyz',
                  //   shopName: 'hockey Academy',
                  //   logoUrl:
                  //       'https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2020/08/12/Pictures/new-zealand-v-india_6285a1d4-dc88-11ea-a145-8bf15479dae6.jpg',
                  //   address: 'pallapatti',
                  //   contactNumber: '9361144746',
                  //   rating: 4,
                  //   openTime: {'hour': '07', 'minute': '30'},
                  //   closeTime: {'hour': '13', 'minute': '30'},
                  // );
                  // FirebaseFirestore.instance
                  //     .collection('preferredShops')
                  //     .add(SalonDetails().toJson(_details));
                  News().getNews();
                },
                child: Container(
                  color: Colors.green,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text('press'),
                ),
              ),
              SingleChildScrollView(
                child: Wrap(
                  children: [
                    PreferredShop(),
                    Divider(),
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
                                                name: snapshot.data.docs[index]
                                                    .data()['name'],
                                                description: snapshot
                                                    .data.docs[index]
                                                    .data()['description'],
                                                address: snapshot
                                                    .data.docs[index]
                                                    .data()['address'],
                                                phone: snapshot.data.docs[index]
                                                    .data()['contact_number'],
                                                imgUrl: snapshot
                                                    .data.docs[index]
                                                    .data()['logoUrl'],
                                                sportsOffered: snapshot
                                                    .data.docs[index]
                                                    .data()['sportsOffered'],
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
        // style: TextStyle(color: Colors.white, fontSize: 16),
        onChanged: (String value) =>
            _shopProvider.changeSelectedLoaction(value),
        hint: Text(
          'Category',
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
