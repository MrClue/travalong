// ! This is User and its data, followed by a toJSON conversion

import 'package:cloud_firestore/cloud_firestore.dart';

final String usersField = 'users'; // Used to refer to collection in Firebase

class UserData {
  static List<String> values = [
    uid, name, email, urlAvatar, city, country, age, bio, connections,
    sharedMedia,
    goalsCompleted, media, chats, interests, travelgoals
    //connection
  ];

  static String uid = 'uid';
  static String name = 'name';
  static String email = 'email';
  static String urlAvatar = 'urlAvatar';
  static String city = 'city';
  static String country = 'country';
  static String age = 'age';
  static String bio = 'bio';
  static String connections = 'connections';
  static String sharedMedia = 'sharedMedia';
  static String goalsCompleted = 'goalsCompleted';
  static String media = 'media';
  static String chats = 'chats';
  static String interests = 'interests';
  static String travelgoals = 'travelgoals';
}

class AppUser {
  String? uid, name, email, urlAvatar, bio, city, country;
  int? age, connections, sharedMedia, goalsCompleted;
  Map<String, Object>? media, chats, interests, travelgoals;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.urlAvatar,
    this.bio,
    this.city,
    this.country,
    this.age,
    this.connections,
    this.sharedMedia,
    this.goalsCompleted,
    this.media,
    this.chats,
    this.interests,
    this.travelgoals,
    // required this.connection,
  });

  //To assist in JSON conversion
  //Map of key value
  Map<String, dynamic> toJson() => {
        UserData.uid: uid,
        UserData.name: name,
        UserData.email: email,
        UserData.urlAvatar: urlAvatar,
        UserData.bio: bio,
        UserData.city: city,
        UserData.country: country,
        UserData.age: age,
        UserData.connections: connections,
        UserData.sharedMedia: sharedMedia,
        UserData.goalsCompleted: goalsCompleted,
        UserData.media: media,
        UserData.chats: chats,
        UserData.interests: interests,
        UserData.travelgoals: travelgoals,
      };

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? urlAvatar,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        urlAvatar: urlAvatar ?? this.urlAvatar,
      );

  static AppUser newfromJSON(Map<String, dynamic> json) => AppUser(
        uid: json[UserData.uid] as String,
        name: json[UserData.name] as String,
        email: json[UserData.email] as String,
      );

  static AppUser fromJSON(Map<String, dynamic> json) => AppUser(
        uid: json[UserData.uid] as String,
        name: json[UserData.name] as String,
        email: json[UserData.email] as String,
        urlAvatar: json[UserData.urlAvatar] as String,
        bio: json[UserData.bio] as String,
        city: json[UserData.city] as String,
        country: json[UserData.country] as String,
        age: json[UserData.age] as int,
        connections: json[UserData.connections] as int,
        sharedMedia: json[UserData.sharedMedia] as int,
        goalsCompleted: json[UserData.goalsCompleted] as int,
        media: json[UserData.media] as Map<String, Object>,
        chats: json[UserData.chats] as Map<String, Object>,
        interests: json[UserData.interests] as Map<String, Object>,
        travelgoals: json[UserData.travelgoals] as Map<String, Object>,
      );
}

class Utils {
  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}
