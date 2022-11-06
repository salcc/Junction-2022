class User {
  final String id;
  final String name;
  final String surname;
  final String imagePath;
  final String gender;
  final String occupation;
  final String description;
  final int age;
  final int mood;

  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.imagePath,
    required this.gender,
    required this.occupation,
    required this.description,
    required this.age,
    required this.mood,
  });

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
      age: 19,
      mood: 3,
    ),
    User(
      id: '99',
      name: 'Bot',
      surname: '',
      imagePath: 'assets/images/female_avatar.png',
      gender: 'Bot',
      occupation: '-',
      description: 'AI bot mediator.',
      age: 2000,
      mood: 4,
    ),
    User(
      id: '2',
      name: 'Hanne',
      surname: 'Virtanen',
      imagePath: 'assets/images/female_avatar.png',
      gender: 'Female',
      occupation: 'Employed',
      description:
          'Waitress during the day, videogame enthusiast during the night. Born and raised in Helsinki. Introvert.',
      age: 20,
      mood: 2,
    ),
    User(
      id: '3',
      name: 'Francesco',
      surname: 'Commodi',
      imagePath: 'assets/images/male_avatar.png',
      gender: 'Male',
      occupation: 'Employed',
      description: '',
      age: 30,
      mood: 3,
    ),
    User(
      id: '4',
      name: 'Juliette',
      surname: 'Evans',
      imagePath: 'assets/images/female_avatar.png',
      gender: 'Female',
      occupation: 'Student',
      description: '',
      age: 18,
      mood: 1,
    ),
  ];
}
