class User {
  final String imagePath;
  final String name;
  final int age, connections, media, goalsCompleted;
  final String city;
  final String country;

  const User({
    required this.imagePath,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.connections,
    required this.media,
    required this.goalsCompleted,
  });
}
