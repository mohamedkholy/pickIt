import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/listings/data/models/listing_status.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class ListingsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Item>?> getListings(String userId) async {
    try {
      final listings =
          await _firestore
              .collection(FirestoreConstants.itemsCollection)
              .where("seller.userId", isEqualTo: userId)
              .get();
      return listings.docs.map((doc) => Item.fromJson(doc.data())).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> updateState(Item item,ListingStatus status) async {
    try {
      await _firestore
          .collection(FirestoreConstants.itemsCollection)
          .doc(item.id)
          .update({"status": status.name});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future deleteItem(Item item) async {
    try {
      await _firestore
          .collection(FirestoreConstants.itemsCollection)
          .doc(item.id)
          .delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
