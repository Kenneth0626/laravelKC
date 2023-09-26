import 'package:flutter/material.dart';

class EmptyListDisplay extends StatelessWidget {
  const EmptyListDisplay({
    super.key,
    required this.label,
    required this.color,
  });
  
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(20.0),

      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
      
    );
  }
}