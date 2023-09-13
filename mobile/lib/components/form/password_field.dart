import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.errorMessage,
    this.confirm,
    this.confirmController,
    this.focusNode,
  });

  final TextEditingController controller;
  final bool? confirm;
  final TextEditingController? confirmController;
  final String? errorMessage;
  final FocusNode? focusNode;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: widget.controller,

      focusNode: widget.focusNode,

      style: const TextStyle(fontSize: 13),

      obscureText: _isHidden,

      decoration: InputDecoration(

        filled: true,

        fillColor: Colors.white,

        prefixIcon: const Icon(Icons.lock),
        
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
        
        labelText: widget.confirm != null ? "Confirm Password" : "Password",

        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
        
        suffixIcon: IconButton(

          icon: Icon( _isHidden ? Icons.visibility : Icons.visibility_off),
          
          onPressed: () {
            setState(() {
              _isHidden = !_isHidden;
            });
          },

          splashColor: Colors.transparent,

          highlightColor: Colors.transparent,

        ),

        errorText: widget.errorMessage,

        errorStyle: TextStyle(
          color: Colors.red[400],
        ),

        

      ),

      validator: (value) {

        RegExp regex = RegExp(r'^.{8,}$');

        if(value!.isEmpty){
          return "Password is Required";
        }

        if(!regex.hasMatch(value)){
          return "Must be at least 8 characters";
        }

        if(widget.confirm != null && widget.confirmController!.text != value){
          return "Password does not match";
        }

        return null;
        
      },

    );
  }
}