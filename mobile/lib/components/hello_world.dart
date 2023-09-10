import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text("Hello World"),
        ), 
      ),
      body: const Center(
        child: Text(
          "Hello World!",
          style: TextStyle(fontSize: 40),  
        ),
      ),
    );
  }
}