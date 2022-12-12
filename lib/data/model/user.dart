import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String idUser;
  final String name;
  final String urlAvatar;
  final DateTime lastMessageTime;

  const User({
    required this.idUser,
    required this.name,
    required this.urlAvatar,
    required this.lastMessageTime,
  });

  User copyWith({
    String? idUser,
    String? name,
    String? urlAvatar,
    String? lastMessageTime,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: this.lastMessageTime,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}

class Utils {
  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}