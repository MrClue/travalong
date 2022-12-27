import 'package:cloud_firestore/cloud_firestore.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String toUser;
  final String fromUser;
  final String content;
  final DateTime createdAt;
  final int type;

  Message({
    required this.toUser,
    required this.fromUser,
    required this.content,
    required this.createdAt,
    required this.type,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        toUser: json['toUser'],
        fromUser: json['fromUser'],
        content: json['content'],
        createdAt: Utils.toDateTime(json['createdAt']),
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'toUser': toUser,
        'fromUser': fromUser,
        'username': content,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
        'type': type,
      };

  factory Message.fromDocument(DocumentSnapshot doc) {
    String toUser = doc.get('toUser');
    String fromUser = doc.get('fromUser');
    String content = doc.get('content');
    DateTime createdAt = doc.get('createdAt');
    int type = doc.get('type');
    return Message(
        toUser: toUser,
        fromUser: fromUser,
        content: content,
        createdAt: createdAt,
        type: type);
  }
}

class Utils {
  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}
