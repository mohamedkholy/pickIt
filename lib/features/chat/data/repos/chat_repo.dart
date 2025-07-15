import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/chat/data/models/message.dart';
import 'package:pickit/features/chats/data/models/chat.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/post_item/data/models/user.dart' as user;

@injectable
class ChatRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<List<Message>?> getMessages(Chat chat) async {
    try {
      final messages =
          await _firestore
              .collection(FirestoreConstants.chatsCollection)
              .doc(chat.id)
              .collection(FirestoreConstants.messagesCollection)
              .orderBy('timestamp', descending: true)
              .get();
      if (messages.docs.isNotEmpty) {
        print("=====================================================");
        updateChatUnreadMessages(chat.id);
      }
      return messages.docs.map((doc) => Message.fromJson(doc.data())).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> createChat(Chat chat) async {
    try {
      await addChatToUser(chat, currentUser.uid);
      await addChatToUser(
        chat.copyWith(
          user: user.User(
            userId: currentUser.uid,
            userName: currentUser.displayName ?? currentUser.email ?? "Unknown",
            userImageUrl: currentUser.photoURL,
          ),
        ),
        chat.user.userId,
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> addChatToUser(Chat chat, String userId) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .collection(FirestoreConstants.userChatsCollection)
        .doc(chat.id)
        .set(chat.toJson());
  }

  Future<bool> sendMessage(Message message, Chat chat) async {
    try {
      final batch = _firestore.batch();
      addMessageToChat(chat.id, message, batch);
      updateChat(
        batch: batch,
        userId: chat.user.userId,
        chatId: chat.id,
        message: message.message,
      );
      updateChat(
        batch: batch,
        userId: currentUser.uid,
        chatId: chat.id,
        message: message.message,
      );
      await batch.commit();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void addMessageToChat(String chatId, Message message, WriteBatch batch) {
    final ref =
        _firestore
            .collection(FirestoreConstants.chatsCollection)
            .doc(chatId)
            .collection(FirestoreConstants.messagesCollection)
            .doc();
    batch.set(ref, message.toJson());
  }

  void updateChat({
    required String userId,
    required String chatId,
    required WriteBatch batch,
    String? message,
  }) {
    final ref = _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .collection(FirestoreConstants.userChatsCollection)
        .doc(chatId);

    if (userId == currentUser.uid) {
      batch.update(ref, {
        'unreadMessages': 0,
        'lastMessage': message,
        'lastMessageTimestamp': DateTime.now(),
      });
    } else if (message != null) {
      batch.update(ref, {
        'unreadMessages': FieldValue.increment(1),
        'lastMessage': message,
        'lastMessageTimestamp': DateTime.now(),
      });
    }
  }

  Future<void> updateChatUnreadMessages(String chatId) async {
    _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(currentUser.uid)
        .collection(FirestoreConstants.userChatsCollection)
        .doc(chatId)
        .update({'unreadMessages': 0});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenToChat(String chatId) {
    return _firestore
        .collection(FirestoreConstants.chatsCollection)
        .doc(chatId)
        .collection(FirestoreConstants.messagesCollection)
        .where('timestamp', isGreaterThan: DateTime.now())
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<Item?> getItem(String chatId) async {
    try {
      final itemId = chatId.split('-')[2];
      final item =
          await _firestore
              .collection(FirestoreConstants.itemsCollection)
              .doc(itemId)
              .get();
      return Item.fromJson(item.data()!);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
