import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String id;
  final String message;
  final String senderId;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      senderId: json['senderId'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return 'Message(id: $id, message: $message, senderId: $senderId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message &&
        other.id == id &&
        other.message == message &&
        other.senderId == senderId &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        senderId.hashCode ^
        timestamp.hashCode;
  }
}
