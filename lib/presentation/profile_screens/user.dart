class User {
  final String imagePath;
  final String name;
  final String age;

  const User({
    required this.imagePath,
    required this.name,
    required this.age
  });
}

class UserPreferences {
  static const myUser = User(
      imagePath: "https://scontent.fcph2-1.fna.fbcdn.net/v/t1.6435-9/58978562_2421381484581270_9069581026195406848_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=Tubl-J0uu3YAX91DV3y&_nc_ht=scontent.fcph2-1.fna&oh=00_AfCBukMqnbIeYyOBkgndlUCRKY_RJwLffSTBd2vkzvqVUA&oe=639DE842",
      name: "Yusaf",
      age: "23"
  );
}