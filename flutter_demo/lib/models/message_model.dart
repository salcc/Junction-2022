class Message {
  final String senderId;
  final String recipientId;
  final String text;
  final DateTime createdAt;

  Message({
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  static List<Message> messages = [
    Message(
      senderId: '1',
      recipientId: '2',
      text: 'Hello',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10),
    ),
    Message(
      senderId: '2',
      recipientId: '1',
      text: 'Hey',
      createdAt: DateTime(2022, 08, 01, 10, 15, 32),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text: 'Good to hear that!',
      createdAt: DateTime(2022, 08, 01, 08, 32, 11),
    )
  ];
}
