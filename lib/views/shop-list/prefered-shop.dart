import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporto/views/description-page/description-page.dart';

import '../../utils/commons.dart';
import 'shop.provider.dart';

class PreferredShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopProvider _shopProvider = Provider.of<ShopProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('preferredShops').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          color: Commons.greyAccent1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(5),
            itemCount: snapshot.data.size,
            itemBuilder: (BuildContext context, num index) {
              String image = snapshot.data.docs[index].data()['logoUrl'];
              String name = snapshot.data.docs[index].data()['name'];
              String address = snapshot.data.docs[index].data()['area'];
              num rating = snapshot.data.docs[index].data()['rating'];
              String area = snapshot.data.docs[index].data()['area'];
              if (_shopProvider.selectedLoaction != 'any' &&
                  _shopProvider.selectedLoaction != area) return Container();
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DescriptionPage(
                              name: snapshot.data.docs[index].data()['name'],
                              description: snapshot.data.docs[index]
                                  .data()['description'],
                              address:
                                  snapshot.data.docs[index].data()['address'],
                              phone: snapshot.data.docs[index]
                                  .data()['contact_number'],
                              imgUrl:
                                  snapshot.data.docs[index].data()['logoUrl'],
                              sportsOffered: snapshot.data.docs[index]
                                  .data()['sportsOffered'],
                            )),
                  );
                },
                child: Card(
                    elevation: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Commons.bgLightColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 3, color: Colors.white),
                        ),
                        width: 175,
                        height: 233,
                        child: Stack(
                          children: [
                            Wrap(children: [
                              Container(
                                height: 120,
                                width: 175,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(
                                  'assets/images/shop-bg.png',
                                  color: Colors.grey,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                height: 233,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ]),
                            Positioned(
                              top: 90,
                              left: 15,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Commons.bgColor, width: .5),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: (image == null || image == '')
                                          ? const AssetImage(
                                              'assets/images/logo.png')
                                          : NetworkImage(image)),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 10),
                                    child: Text(
                                      address,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 15,
                                  ),
                                  Text(
                                    rating.toString(), //rating,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              );
            },
          ),
        );
      },
    );
  }
}
