import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class SearchRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Item>?> search(String query) async {
    try {
      final items =
          await _firestore
              .collection(FirestoreConstants.itemsCollection)
              .where('title', isGreaterThanOrEqualTo: query)
              .where('title', isLessThanOrEqualTo: "$query\uf8ff")
              .get();
      return items.docs.map((e) => Item.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
