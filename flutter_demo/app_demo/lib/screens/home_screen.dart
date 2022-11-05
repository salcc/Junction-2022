import 'package:flutter/material.dart';

import '../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          appBar: AppBar(
            title: Text(
              'Main Menu',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            elevation: 0,
          ),
          body: Container(
            child: Column(children: [
              Container(
                height: height * 0.125,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      User user = users[index];
                      return CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(user.imagePath));
                    }),
              )
            ]),
          ),
        ));
  }
}
