import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
    this.errorMessage,
    this.focusNode,
  });

  final TextEditingController controller;
  final String? errorMessage;
  final FocusNode? focusNode;
  
  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,

      focusNode: focusNode,

      style: const TextStyle(fontSize: 13,),

      decoration: InputDecoration(

        filled: true,

        fillColor: Colors.white,

        prefixIcon: const Icon(Icons.mail),

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
        
        labelText: "Email",

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

        if(value!.isEmpty){
          return "Email is Required";
        }

        if(!EmailValidator.validate(value)){
          return "Invalid Email Address";
        }

        return null;

      },

    );
  }
}