import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/post_item/data/models/item.dart';

@injectable
class PostItemRepo {
  final Reference _storage = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User _user = FirebaseAuth.instance.currentUser!;

  Future<bool> postItem(Item item) async {
    try {
      final imageUrls = await uploadImages(item.photos);
      if (imageUrls == null) {
        return false;
      }
      final itemData = item.toJson();
      itemData['photos'] = imageUrls;
      itemData["id"] = "${_user.uid}_${DateTime.now().millisecondsSinceEpoch}";
      await _firestore
          .collection(FirestoreConstants.itemsCollection)
          .doc( itemData["id"])
          .set(itemData);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<List<String>?> uploadImages(List<String> images) async {
    try {
      final List<String> imageUrls = [];
      for (var image in images) {
        final imageRef = _storage.child(
          "items/${DateTime.now().millisecondsSinceEpoch}.jpg",
        );
        await imageRef.putFile(File(image));
        final imageUrl = await imageRef.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String getUserID() {
    return _user.uid;
  }

  String getUserName() {
    return _user.displayName ?? "";
  }

  String getUserImageUrl() {
    return _user.photoURL ?? "";
  }
}
