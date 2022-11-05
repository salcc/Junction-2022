import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/main_container.dart';
import '../widgets/mood_chart.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<User> users = User.users;

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
          _ProfileBar(height: height, width: width, user: users[0]),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const Padding(
                    padding: EdgeInsets.all(20.0), child: MoodBarChart()),
                BottomBar(width: width),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _ProfileBar extends StatelessWidget {
  const _ProfileBar({
    Key? key,
    required this.height,
    required this.width,
    required this.user,
  }) : super(key: key);

  final double height;
  final double width;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.2,
        margin: const EdgeInsets.only(left: 20, top: 20),
        child: Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(user.imagePath)),
                  ],
                )),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20, top: 10),
              width: width * 0.475,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name} ${user.surname}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text('${user.age}, ${user.gender}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 10),
                  Text(
                    user.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
