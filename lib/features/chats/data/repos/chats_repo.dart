import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:pickit/core/constants/firestore_constants.dart';
import 'package:pickit/features/chats/data/models/chat.dart';

@injectable
class ChatsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<bool> isUserLoggedIn() async {
    return currentUser != null;
  }

  Future<List<Chat>> getChats() async {
    final chats =
        await _firestore
            .collection(FirestoreConstants.usersCollection)
            .doc(currentUser!.uid)
            .collection(FirestoreConstants.userChatsCollection)
            .get();
    return chats.docs.map((doc) => Chat.fromJson(doc.data())).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenToChats() {
    return _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(currentUser!.uid)
        .collection(FirestoreConstants.userChatsCollection)
        .orderBy('lastMessageTimestamp', descending: true)
        .orderBy('unreadMessages', descending: true) 
        .snapshots();
  }
}
