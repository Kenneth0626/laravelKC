import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    this.onTap,
    required this.label,
    this.emailController,
    this.passwordController,
  });

  final String label;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
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

      child: Text(label),

    );
  }
}
