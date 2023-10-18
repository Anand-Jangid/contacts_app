import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {super.key,
      required this.icons,
      required this.onPressed,
      required this.title,
      this.size = 20});
  final IconData icons;
  final void Function() onPressed;
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: size,
          child: IconButton(
            icon: Icon(icons, size: size,),
            onPressed: onPressed,
          ),
        ),
        Text(title)
      ],
    );
  }
}
