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
    )
  ];
}
