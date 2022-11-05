class User {
  final String id;
  final String name;
  final String surname;
  final String imagePath;
  final String gender;
  final String occupation;
  final String description;
  final int age;

  const User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.imagePath,
      required this.gender,
      required this.occupation,
      required this.description,
      required this.age});

  static const List<User> users = [
    User(
        id: '1',
        name: 'John',
        surname: 'Lee',
        imagePath: 'assets/images/male_avatar.png',
        gender: 'Male',
        occupation: 'Student',
        description:
            'Computer science student. Just moved to Helsinki. LoL enthusiast.',
        age: 19),
    User(
        id: '2',
        name: 'Hanne',
        surname: 'Virtanen',
        imagePath: 'assets/images/female_avatar.png',
        gender: 'Female',
        occupation: 'Employed',
        description:
            'Waitress during the day, videogame enthusiast during the night. Born and raised in Helsinki. Introvert.',
        age: 20),
  ];
}
