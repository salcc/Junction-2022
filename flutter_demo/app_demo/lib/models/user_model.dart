class User {
  final String id;
  final String name;
  final String surname;
  final String imageUrl;

  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.imageUrl,
  });

  static const List<User> users = [
    User(id: '1', name: 'John', surname: 'WH', imageUrl: 'www.xxx.com')
  ];
}
