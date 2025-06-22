import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class BrowseRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Item>> getItems({String? category}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> items;
      if (category == null) {
        items = await _firestore
            .collection(FirestoreConstants.itemsCollection)
            .get();
      } else {
        items = await _firestore
            .collection(FirestoreConstants.itemsCollection)
            .where("category", isEqualTo: category)
            .get();
      }
      return items.docs.map((doc) => Item.fromJson(doc.data())).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
