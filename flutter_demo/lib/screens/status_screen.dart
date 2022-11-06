import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

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
        body: Column(children: [
          const SizedBox(height: 25),
          _Salute(height: height, width: width, user: users[0]),
          _Emotions(height: height),
        ]),
      ),
    );
  }
}

class _Salute extends StatelessWidget {
  const _Salute({
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
        margin: const EdgeInsets.only(left: 2, top: 150),
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20, top: 10),
              width: width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${user.name} ${user.surname}!',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text('How are you doing today?',
                      style: Theme.of(context).textTheme.titleLarge!,
                      textAlign: TextAlign.left),
                  const SizedBox(height: 5),
                ],
              ),
            )
          ],
        ));
  }
}

class _Emotions extends StatelessWidget {
  const _Emotions({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return StatusContainer(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return IconButton(
                iconSize: 60,
                onPressed: () {
                  Get.toNamed('/profile');
                },
                icon: Container(
                  margin: const EdgeInsets.only(right: 2, left: 2),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors[index],
                  ),
                ));
          }),
    );
  }
}

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: Theme.of(context).colorScheme.background.withOpacity(0.8),
      ),
      child: child,
    );
  }
}
