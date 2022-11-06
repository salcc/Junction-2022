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
      text: 'Hello!',
      createdAt: DateTime(2022, 08, 01, 10, 10, 10),
    ),
    Message(
      senderId: '2',
      recipientId: '1',
      text: 'Hey',
      createdAt: DateTime(2022, 08, 01, 10, 15, 32),
    ),
    Message(
      senderId: '1',
      recipientId: '2',
      text: 'Indeed, I am kind of a LoL nerd. Hahah',
      createdAt: DateTime(2022, 08, 01, 10, 17, 32),
    ),
    Message(
      senderId: '1',
      recipientId: '2',
      text: 'What games do you play?',
      createdAt: DateTime(2022, 08, 01, 10, 18, 32),
    ),
    Message(
      senderId: '2',
      recipientId: '1',
      text:
          "Cool! I have played LoL too. Though lately I've been playing 1 player games.",
      createdAt: DateTime(2022, 08, 01, 10, 19, 32),
    ),
    Message(
      senderId: '2',
      recipientId: '1',
      text: "Are you following LoL Worlds?",
      createdAt: DateTime(2022, 08, 01, 10, 20, 32),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text: 'How did it go yesterday?',
      createdAt: DateTime(2022, 08, 01, 08, 32, 11),
    ),
    Message(
      senderId: '1',
      recipientId: '3',
      text: 'Really f***ing bad',
      createdAt: DateTime(2022, 08, 01, 08, 33, 11),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text: "What happened?",
      createdAt: DateTime(2022, 08, 01, 08, 35, 11),
    ),
    Message(
      senderId: '1',
      recipientId: '3',
      text:
          "Honestly, everyhting went wrong. And I'm really mad about how my exams went. My family is paying so much for me to study abroad and I can't even pass or make friends.",
      createdAt: DateTime(2022, 08, 01, 08, 36, 11),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text: "I understand you, I've been thorugh something similar too.",
      createdAt: DateTime(2022, 08, 01, 08, 37, 11),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text:
          "Even though it's not easy now, you'll see that you'll make some good friends. It's just been not too long since you moved, make sure to wander more around uni!",
      createdAt: DateTime(2022, 08, 01, 08, 38, 11),
    ),
    Message(
      senderId: '3',
      recipientId: '1',
      text:
          "Also don't worry about the grades. They're not as important as they seem. Most of the times you can easily recover form one bad exam.",
      createdAt: DateTime(2022, 08, 01, 08, 39, 11),
    ),
    Message(
      senderId: '99',
      recipientId: '3',
      text:
          "Hey! Take it easy. It was probably not as bad as you think. Am I right Francesco?",
      createdAt: DateTime(2022, 08, 01, 08, 34, 11),
    ),
    Message(
      senderId: '99',
      recipientId: '2',
      text: "Hey! I think you could get along and understand each other.",
      createdAt: DateTime(2022, 08, 01, 8, 16, 11),
    ),
    Message(
      senderId: '99',
      recipientId: '2',
      text: "I know you both like videogames!",
      createdAt: DateTime(2022, 08, 01, 8, 17, 11),
    ),
  ];
}
