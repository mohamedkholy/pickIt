import 'package:flutter/foundation.dart';

class Item {
  final String title;
  final double price;
  final String category;
  final String description;
  final List<String> photos; 

  Item({
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.photos,
  });

  Map<String, dynamic> toJson() { 
    return {
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'photos': photos,
    };
  }   


  factory Item.fromJson(Map<String, dynamic> json) {
    final photos = json['photos'] as List<dynamic>;
    final List<String> photoList = photos.map((photo) => photo.toString()).toList();
    return Item(
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      photos: photoList,
    );
  } 

  @override
  String toString() {
    return 'Item(title: $title, price: $price, category: $category, description: $description, photos: $photos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item &&
        other.title == title &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        listEquals(other.photos, photos);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        photos.hashCode;
  }
}
