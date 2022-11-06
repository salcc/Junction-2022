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
        margin: const EdgeInsets.only(left: 20, top: 150),
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20, top: 10),
              width: width * 0.475,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${user.name} ${user.surname}!',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text('How are you doing today?',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 10),
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
    return Container(
      height: height * 0.15,
      margin: const EdgeInsets.only(left: 20, top: 10),
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
                  margin: const EdgeInsets.only(right: 15),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                    color: colors[index],
                  ),
                ));
          }),
    );
  }
}
