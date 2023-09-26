import 'package:flutter/material.dart';

class LoadMoreDisplay extends StatelessWidget {
  const LoadMoreDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(

      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text("Scroll up to load more..."),
      ),
      
    );
  }
}