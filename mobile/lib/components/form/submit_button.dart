import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.label,
    this.labelSize = 18,
    this.onTap,
  });

  final String label;
  final double labelSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onTap,

      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 40),
      ),

      child: Text(
        label,
        style: TextStyle(
          fontSize: labelSize,
        ),
      ),

    );
  }
}
