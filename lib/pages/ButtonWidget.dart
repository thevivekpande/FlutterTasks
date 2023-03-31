import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final String title;
  final void Function() onPressed;
  final double width;

  ButtonWidget(
      {super.key,
      required this.color,
      required this.title,
      required void Function() this.onPressed,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
