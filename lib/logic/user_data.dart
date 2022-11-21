import 'user.dart';

// TODO: (UserData) fields should be retrieved from Database

class UserData {
  static const dummyUser = User(
    imagePath: "https://pfpmaker.com/_nuxt/img/profile-3-1.3e702c5.png",
    name: "Stephanie",
    age: 26,
    city: "Odense",
    country: "Denmark",
    connections: 123,
    media: 10,
    goalsCompleted: 40,
  );
}
