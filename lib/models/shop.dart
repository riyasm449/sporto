import 'package:flutter/material.dart';

class Ambiences {
  final num id;
  final String name;
  final IconData icon;

  Ambiences({this.id, this.name, this.icon});
}

class PreferredSalon {
  final num id;
  final String shopName;
  final String imgUrl;
  final String address;
  final num rating;

  PreferredSalon(
      {this.id, this.shopName, this.imgUrl, this.address, this.rating});
}

class ShopDetails {
  final String shopId;
  final String shopName;
  final String logoUrl;
  final String address;
  final String contactNumber;
  final num rating;
  // final List<SalonAmbiances> ambiance;
  final Map openTime; //{'hour':'13','minute':'30'}
  final Map closeTime; //{'hour':'13','minute':'30'}

  ShopDetails({
    this.shopId,
    this.shopName,
    this.logoUrl,
    this.address,
    this.contactNumber,
    this.rating,
    // this.ambiance,
    this.openTime,
    this.closeTime,
  });

  Map<String, dynamic> toJson(ShopDetails details) {
    return {
      'id': details.shopId,
      'name': details.shopName,
      'contact_number': details.contactNumber,
      'logoUrl': details.logoUrl,
      'address': details.address,
      'rating': details.rating,
      'openTime': details.openTime,
      'closeTime': details.closeTime
    };
  }

  factory ShopDetails.fromJson(Map<String, dynamic> json) {
    return ShopDetails(
        shopId: json['id'] ?? '',
        shopName: json['name'] ?? '',
        contactNumber: json['contact_number'] ?? '',
        logoUrl: json['logoUrl'] ?? '',
        address: json['address'] ?? '',
        // ambiance: json['ambiences']
        //         ?.map((_ambience) => SalonAmbiances.fromJson(_ambience))
        //         .cast<SalonAmbiances>()
        //         .toList() ??
        //     [],
        rating: 5,
        openTime: {'hour': '09', 'minute': '30'},
        closeTime: {'hour': '13', 'minute': '30'});
  }
}

class SalonAmbiances {
  final num id;
  final String name;

  SalonAmbiances({this.id, this.name});

  factory SalonAmbiances.fromJson(Map<String, dynamic> json) {
    return SalonAmbiances(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SearchList {
  final num id;
  final String name;
  final String category;

  SearchList({this.id, this.name, this.category});
}

class UserLocation {
  final String address;
  final String locality;
  final num latitude;
  final num longitude;

  UserLocation({this.address, this.locality, this.latitude, this.longitude});
}
