class ShopDetails {
  final String shopId;
  final String shopName;
  final String imgUrl;
  final String address;
  final String area;
  final String description;

  final String contactNumber;
  final num rating;

  ShopDetails(
      {this.shopId,
      this.shopName,
      this.imgUrl,
      this.address,
      this.contactNumber,
      this.description,
      this.rating,
      this.area});

  Map<String, dynamic> toJson(ShopDetails details) {
    return {
      'id': details.shopId,
      'name': details.shopName,
      'contact_number': details.contactNumber,
      'logoUrl': details.imgUrl,
      'address': details.address,
      'rating': details.rating,
      'area': details.area,
      'description': details.description,
    };
  }

  factory ShopDetails.fromJson(Map<String, dynamic> json) {
    return ShopDetails(
      shopId: json['id'] ?? '',
      shopName: json['name'] ?? '',
      description: json['description'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      imgUrl: json['logoUrl'] ?? '',
      address: json['address'] ?? '',
      area: json['area'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}
