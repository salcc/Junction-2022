import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.width}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65,
        width: width * 0.5,
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withAlpha(150),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primary.withAlpha(255)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/profile');
                  },
                  icon: const Icon(
                      color: Colors.black, Icons.person_outline_outlined)),
            ),
            const SizedBox(width: 30),
            Material(
              color: Colors.transparent,
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/social');
                  },
                  icon:
                      const Icon(color: Colors.black, Icons.message_outlined)),
            ),
          ],
        ),
      ),
    );
  }
}
