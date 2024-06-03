import 'package:flutter/material.dart';

class BRBMenuItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Function() onPressed;

  const BRBMenuItem({super.key, this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
