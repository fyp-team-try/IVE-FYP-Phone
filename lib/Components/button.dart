import 'package:flutter/material.dart';

enum MyButtonType { submit }

extension MyButtonTypeExtension on MyButtonType {
  Color get color {
    switch (this) {
      case MyButtonType.submit:
        return Colors.black;
    }
  }
}

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final MyButtonType type;
  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
