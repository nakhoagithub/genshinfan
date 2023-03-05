import 'package:flutter/material.dart';
import 'package:genshinfan/objects/domain.dart';

class ItemDomain extends StatelessWidget {
  final Domain domain;
  final VoidCallback onTap;
  const ItemDomain({
    super.key,
    required this.domain,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
