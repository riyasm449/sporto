import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sporto/utils/commons.dart';

import '../../models/shop.dart';
import '../../utils/commons.dart';

class SalonCard extends StatelessWidget {
  final ShopDetails shopDetails;

  const SalonCard({Key key, @required this.shopDetails}) : super(key: key);


  static Container _salonLogoPlaceHolder() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 170,
        ),
        Positioned(
          top: 5,
          right: 10,
          left: 10,
          child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Commons.bgLightColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Commons.greyAccent2)),
          ),
        ),
        Positioned(
          top: 5.5,
          right: 10.5,
          left: 10.5,
          child: CachedNetworkImage(
            imageUrl: shopDetails.imgUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: 89.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => _salonLogoPlaceHolder(),
            errorWidget: (context, url, error) => _salonLogoPlaceHolder(),
          ),
        ),
        Positioned(
            top: 100,
            left: 20,
            child: Text(
              shopDetails.shopName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Commons.bgColor
              ),
            )),
        Positioned(
          top: 100,
          right: 20,
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.orange,
                size: 15,
              ),
              Text(
                '${shopDetails.rating.toString()}/5', //rating,
                style: TextStyle(
                    fontSize: 11, color: Colors.black.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Text(
              shopDetails.address,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
              ),
            )),
      ],
    );
  }
}
