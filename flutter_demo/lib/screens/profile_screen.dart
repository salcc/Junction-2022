import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/main_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<User> users = User.users;
    List<Chat> chats = Chat.chats;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ])),
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'My Profile',
        //     style: Theme.of(context)
        //         .textTheme
        //         .titleLarge!
        //         .copyWith(fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: false,
        //   elevation: 0,
        // ),
        body: Column(children: [
          const SizedBox(height: 30),
          _SocialBar(height: height, users: users),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // _ChatPreview(height: height, chats: chats),
                BottomBar(width: width),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _SocialBar extends StatelessWidget {
  const _SocialBar({
    Key? key,
    required this.height,
    required this.users,
  }) : super(key: key);

  final double height;
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.125,
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(user.imagePath)),
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ));
          }),
    );
  }
}
