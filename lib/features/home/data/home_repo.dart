import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class HomeRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Item>> getFeaturedItems() async {
    try {
      final items = await _firestore
        .collection(FirestoreConstants.itemsCollection)
        .where("status", isEqualTo: "active")
        .get();
    final shuffledItems = items.docs
        .map((doc) => Item.fromJson(doc.data()))
        .toList();
    shuffledItems.shuffle();
    return shuffledItems.take(3).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}