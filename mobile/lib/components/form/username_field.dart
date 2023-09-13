import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    required this.controller,
    this.errorMessage,
  });

  final TextEditingController controller;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,

      style: const TextStyle(fontSize: 13,),

      decoration: InputDecoration(

        filled: true,

        fillColor: Colors.white,

        prefixIcon: const Icon(Icons.person),

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: (Colors.red[400])!)
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: (Colors.red[800])!)
        ),
        
        labelText: "Username",

        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),

        errorStyle: TextStyle(
          color: Colors.red[400],
        ),

        errorText: errorMessage,

      ),

      validator: (value) {

        RegExp regexAlphaNum = RegExp(r'^[a-zA-Z0-9]+$');
        RegExp regexAtLeastThree = RegExp(r'^.{3,}$');

        if(value!.isEmpty){
          return "Username is Required";
        }
        
        if(!regexAtLeastThree.hasMatch(value)){
          return "Must be at least 3 characters";
        }

        if(!regexAlphaNum.hasMatch(value)){
          return "Must not contain special characters";
        }

        return null;

      },

    );
  }
}