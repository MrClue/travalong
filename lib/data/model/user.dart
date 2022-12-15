// ! This is User and its data, followed by a toJSON conversion

// * This class handles the JSON key-value pairs with the UserData being the key
class UserData {
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

// * This class provides the values for each key in the JSON format
class AppUser {
  String? uid, name, email, urlAvatar, bio, city, country;
  int? age, connections, sharedMedia, goalsCompleted;
  Map<String, dynamic>? media, chats, interests, travelgoals;

  AppUser({
    required this.uid,
    this.name,
    this.email,
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

  // To assist in JSON conversion
  // Map of key value
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

  // * This method can be used on a current AppUser to return a new instance of the AppUser,
  // * with updated values for each of the properties listed below.
  AppUser updateField({
    String? uid,
    String? name,
    String? email,
    String? urlAvatar,
    String? city,
    String? country,
    int? age,
    String? bio,
    int? connections,
    int? sharedMedia,
    int? goalsCompleted,
    Map<String, dynamic>? media,
    Map<String, dynamic>? chats,
    Map<String, dynamic>? interests,
    Map<String, dynamic>? travelgoals,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        city: city ?? this.city,
        country: country ?? this.country,
        age: age ?? this.age,
        bio: bio ?? this.bio,
        connections: connections ?? this.connections,
        sharedMedia: sharedMedia ?? this.sharedMedia,
        goalsCompleted: goalsCompleted ?? this.goalsCompleted,
        media: media ?? this.media,
        chats: chats ?? this.chats,
        interests: interests ?? this.interests,
        travelgoals: travelgoals ?? this.travelgoals,
      );

  static AppUser newfromJSON(Map<String, dynamic> json) => AppUser(
        uid: json[UserData.uid] as String,
        name: json[UserData.name] as String,
        email: json[UserData.email] as String,
      );

  // * This method can be used to get the AppUser data from the Firebase DB (stored in JSON format),
  // * and convert it to an object instance of AppUser
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
        media: json[UserData.media] as Map<String, dynamic>,
        chats: json[UserData.chats] as Map<String, dynamic>,
        interests: json[UserData.interests] as Map<String, dynamic>,
        travelgoals: json[UserData.travelgoals] as Map<String, dynamic>,
      );
}
