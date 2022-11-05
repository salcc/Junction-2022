class User {
  final String id;
  final String name;
  final String surname;
  final String imagePath;

  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.imagePath,
  });

  static const List<User> users = [
    User(
        id: '1',
        name: 'John',
        surname: 'WH',
        imagePath: 'assets/images/male_avatar.png'),
    User(
        id: '2',
        name: 'Maria',
        surname: 'JK',
        imagePath: 'assets/images/female_avatar.png'),
  ];
}
