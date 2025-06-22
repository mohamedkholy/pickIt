import 'package:flutter/foundation.dart';

class Item {
  final String title;
  final double price;
  final String category;
  final String description;
  final List<String> photos;
  final String sellerId;
  final String sellerName;
  final String? sellerImageUrl;
  final String city;

  Item({
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.photos,
    required this.sellerId,
    required this.sellerName,
    this.sellerImageUrl,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'photos': photos,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'sellerImageUrl': sellerImageUrl ?? "",
      'city': city,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    final photos = json['photos'] as List<dynamic>;
    final List<String> photoList =
        photos.map((photo) => photo.toString()).toList();
    return Item(
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      photos: photoList,
      sellerId: json['sellerId'],
      sellerName: json['sellerName'],
      sellerImageUrl: json['sellerImageUrl'] ?? "",
      city: json['city'],
    );
  }

  @override
  String toString() {
    return 'Item(title: $title, price: $price, category: $category, description: $description, photos: $photos, sellerId: $sellerId, sellerName: $sellerName, sellerImageUrl: $sellerImageUrl, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item &&
        other.title == title &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        listEquals(other.photos, photos) &&
        other.sellerId == sellerId &&
        other.sellerName == sellerName &&
        other.sellerImageUrl == sellerImageUrl &&
        other.city == city;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        photos.hashCode ^
        sellerId.hashCode ^
        sellerName.hashCode ^
        sellerImageUrl.hashCode ^
        city.hashCode;
  }
}
