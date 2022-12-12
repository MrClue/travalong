class User {
  String uid, name, city, country;
  int age, connections, sharedMedia, goalsCompleted;
  late Map<String, String> media, chats, interest, travelGoals;
  //connection

  User({
    required this.uid,
    required this.name,
    required this.city,
    required this.country,
    required this.age,
    required this.connections,
    required this.sharedMedia,
    required this.goalsCompleted,
    // required this.connection,
  });
}
