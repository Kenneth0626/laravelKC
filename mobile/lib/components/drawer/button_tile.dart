import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  const ButtonTile({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      title : Text(label),

      onTap: onTap,

    );
  }
}