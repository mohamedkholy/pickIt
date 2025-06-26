import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class ProfileRepo {
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

}
