import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late User user;
  late Chat chat;

  @override
  void initState() {
    user = Get.arguments[0];
    chat = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
          appBar: _CustomAppBar(
            user: user,
          ),
          body: Column(children: [])),
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Column(
          children: [
            Text(
              '${user.name} ${user.surname}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Online',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        elevation: 0,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage(user.imagePath),
              ))
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
