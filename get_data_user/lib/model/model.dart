class User {
  final String id;
  final String name;
  final String sex;
  final String location;

  User({
    required this.id,
    required this.name,
    required this.sex,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      sex: json['sex'],
      location: json['location'],
    );
  }
}
