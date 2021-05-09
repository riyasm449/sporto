import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/shop.dart';
import '../../utils/commons.dart';

class AddShop extends StatefulWidget {
  final bool prefrerred;

  const AddShop({Key key, this.prefrerred = false}) : super(key: key);
  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  final addressField = TextEditingController();
  final phoneField = TextEditingController();
  final shopNameField = TextEditingController();
  final descriptionField = TextEditingController();
  final areaField = TextEditingController();
  final ratingField = TextEditingController();
  final imgurlField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Commons.appBar,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 15,
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_cart_outlined,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    controller: shopNameField,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Shop name',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.call_outlined,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    controller: phoneField,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Phone number',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    minLines: 2,
                    maxLines: 15,
                    controller: descriptionField,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Description',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.image_outlined,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    minLines: 1,
                    maxLines: 15,
                    controller: imgurlField,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Image url',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add_business_rounded,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    minLines: 2,
                    maxLines: 5,
                    controller: addressField,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Address',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add_location_alt_outlined,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    controller: areaField,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Area',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star_outline,
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(border: Border.all(width: .5)),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    maxLength: 1,
                    controller: ratingField,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Rating',
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _addItemButton(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void clearText() {
    shopNameField.clear();
    ratingField.clear();
    descriptionField.clear();
    phoneField.clear();
    addressField.clear();
    imgurlField.clear();
    areaField.clear();
  }

  Widget _addItemButton() {
    return GestureDetector(
      onTap: () async {
        ShopDetails details = ShopDetails(
            shopName: shopNameField.text,
            address: addressField.text,
            rating: int.parse(ratingField.text),
            description: descriptionField.text,
            contactNumber: phoneField.text,
            imgUrl: imgurlField.text,
            area: areaField.text);
        await FirebaseFirestore.instance
            .collection(widget.prefrerred ? 'preferredShops' : 'shops')
            .add(ShopDetails().toJson(details))
            .then((value) {
          clearText();
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(2)),
        child: Text(
          'Add item',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
