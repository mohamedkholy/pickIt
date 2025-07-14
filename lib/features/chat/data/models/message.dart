import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String message;
  final String senderId;
   final String receiverId ;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'senderId': senderId,
      'receiverId':receiverId,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return 'Message(id: $id, message: $message, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message &&
        other.id == id &&
        other.message == message &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        timestamp.hashCode;
  }
}
