import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/post_item/data/models/user.dart';

class Chat {
  final String id;
  final Item item;
  final User user;
  final String? lastMessage;
  final int unreadMessages;
  late final DateTime lastMessageTimestamp;
  Chat({
    required this.id,
    required this.item,
    required this.user,
    this.lastMessage,
    this.unreadMessages = 0,
    DateTime? lastMessageTimestamp,
  }) {
    this.lastMessageTimestamp = lastMessageTimestamp ?? DateTime.now();
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      item: Item.fromJson(json['item']),
      user: User.fromJson(json['user']),
      lastMessage: json['lastMessage'],
      unreadMessages: json['unreadMessages'],
      lastMessageTimestamp:
          (json['lastMessageTimestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item.toJson(),
      'user': user.toJson(),
      'lastMessage': lastMessage,
      'unreadMessages': unreadMessages,
      'lastMessageTimestamp': lastMessageTimestamp,
    };
  }

  Chat copyWith({
    Item? item,
    User? user,
    String? lastMessage,
    int? unreadMessages,
    DateTime? lastMessageTimestamp,
  }) {
    return Chat(
      id: id,
      item: item ?? this.item,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadMessages: unreadMessages ?? this.unreadMessages,
      lastMessageTimestamp: lastMessageTimestamp,
    );
  }

  @override
  String toString() {
    return 'Chat(id: $id, item: $item, user: $user, lastMessage: $lastMessage, unreadMessages: $unreadMessages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Chat &&
        other.id == id &&
        other.item == item &&
        other.user == user &&
        other.lastMessage == lastMessage &&
        other.unreadMessages == unreadMessages &&
        other.lastMessageTimestamp == lastMessageTimestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        item.hashCode ^
        user.hashCode ^
        lastMessage.hashCode ^
        unreadMessages.hashCode ^
        lastMessageTimestamp.hashCode;
  }
}
