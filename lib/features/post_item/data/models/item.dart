import 'package:flutter/foundation.dart';
import 'package:pickit/features/post_item/data/models/user.dart';

class Item {
  final String id;
  final String title;
  final double price;
  final String category;
  final String description;
  final List<String> photos;
  final User seller;  
  final String city;

  Item({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.photos,
    required this.seller,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'photos': photos,
      'seller': seller.toJson(),
      'city': city,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    final photos = json['photos'] as List<dynamic>;
    final List<String> photoList =
        photos.map((photo) => photo.toString()).toList();
    return Item(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      photos: photoList,
      seller: User.fromJson(json['seller']),
      city: json['city'],
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, title: $title, price: $price, category: $category, description: $description, photos: $photos, seller: $seller, city: $city)';
  } 

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item &&
        other.id == id &&
        other.title == title &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        listEquals(other.photos, photos) &&
        other.seller == seller &&
        other.city == city;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        photos.hashCode ^
        seller.hashCode ^
        city.hashCode;
  }
}
