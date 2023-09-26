import 'package:flutter/material.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(

      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
      
    );
  }
}