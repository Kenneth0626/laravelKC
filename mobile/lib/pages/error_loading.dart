import 'package:flutter/material.dart';

class ErrorLoading extends StatelessWidget {
  const ErrorLoading({
    super.key,
    required this.onReset,
  });

  final Function() onReset;

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text("Error has occured."),

            const Text("Please Try Again."),

            ElevatedButton(
              onPressed: () {
                onReset();
              },
              child: const Text("Retry"),
            ),

          ],
        ),
      ),
      
    );
  }
}