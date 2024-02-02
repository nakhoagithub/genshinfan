import 'package:flutter/material.dart';

class CheckboxRarity extends StatelessWidget {
  final VoidCallback onTap;
  final bool value;
  const CheckboxRarity({
    super.key,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 24,
        height: 24,
        child: value
            ? Icon(Icons.star, color: Colors.amber[600])
            : Icon(Icons.star_border_outlined, color: Colors.amber[600]),
      ),
    );
  }
}
