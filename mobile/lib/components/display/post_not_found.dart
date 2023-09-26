import 'package:flutter/material.dart';

class PostNotFound extends StatelessWidget {
  const PostNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Post Not Found"),
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Theme.of(context).shadowColor,
      ),

      body: const Center(
          child: Text(
            "Post Not Found.",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      
    );
  }
}