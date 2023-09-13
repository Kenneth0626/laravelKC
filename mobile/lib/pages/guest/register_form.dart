import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/authenticated_drawer.dart';
import 'package:mobile/components/drawer/guest_drawer.dart';
import 'package:mobile/components/form/email_field.dart';
import 'package:mobile/components/form/password_field.dart';
import 'package:mobile/components/form/submit_button.dart';
import 'package:mobile/components/form/username_field.dart';
import 'package:mobile/pages/guest/login_form.dart';
import 'package:mobile/pages/page_layout.dart';
import 'package:mobile/pages/user/welcome.dart';
import 'package:mobile/services/register_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _registerFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  dynamic error;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void signUp() async{

    if(_registerFormKey.currentState!.validate()){
      
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );

      dynamic status = await registerService(jsonEncode({
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "password_confirmation": _confirmPasswordController.text,
      }));

      if(status == 200 && context.mounted){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PageLayout(
              label: "Home",
              drawer: AuthenticatedDrawer(page: "Home"),
              child: Welcome(),
            ))
        );
      }

      if(status != 200 && context.mounted){

        _passwordController.clear();
        _confirmPasswordController.clear();

        if(status != -1){
          setState(() {
            error = status;
          });
        }

        Navigator.of(context, rootNavigator: true).pop();
        
        if(status == -1){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error has occured. Check your Internet Connection"),
            )
          );
        }
      }
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.only(
        left: 20, 
        right: 20
      ),

      child: SingleChildScrollView(
        child: Column(
          children: [

            Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  UsernameField(
                    controller: _usernameController,
                    errorMessage: error?['username']?[0],
                  ),
                  const SizedBox(height: 10,),
                  EmailField(
                    controller: _emailController,
                    errorMessage: error?['email']?[0],
                  ),
                  const SizedBox(height: 10,),
                  PasswordField(controller: _passwordController,),
                  const SizedBox(height: 10,),
                  PasswordField(
                    confirm: true,
                    controller: _confirmPasswordController,
                    confirmController: _passwordController,
                    errorMessage: error?['password']?[0],
                  ),
                  const SizedBox(height: 10,),
                  SubmitButton(
                    label: "Register",
                    onTap: signUp,
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                   style: TextStyle(fontSize: 13),
                ),
                TextButton(
                  onPressed:(){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const PageLayout(
                          label: "Login",
                          drawer: GuestDrawer(page: "Login"),
                          child: LoginForm(),
                        ))
                    );
                  }, 
                  child: const Text(
                    "Login Now!",
                    style: TextStyle(fontSize: 13)
                  ),
                ),
              ],
            )

          ],
        ),
      ),

    );
  }
}