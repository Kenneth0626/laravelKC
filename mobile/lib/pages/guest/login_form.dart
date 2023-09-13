import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/authenticated_drawer.dart';
import 'package:mobile/components/drawer/guest_drawer.dart';
import 'package:mobile/components/form/email_field.dart';
import 'package:mobile/components/form/password_field.dart';
import 'package:mobile/components/form/submit_button.dart';
import 'package:mobile/pages/guest/register_form.dart';
import 'package:mobile/pages/page_layout.dart';
import 'package:mobile/pages/user/welcome.dart';
import 'package:mobile/services/login_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  dynamic error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void signIn() async{

    if(_loginFormKey.currentState!.validate()){
      
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );

      dynamic status = await loginService(jsonEncode({
        "email": _emailController.text,
        "password": _passwordController.text,
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
              key: _loginFormKey,
              child: Column(
                children: [
                  EmailField(controller: _emailController,),
                  const SizedBox(height: 20,),
                  PasswordField(
                    controller: _passwordController,
                    errorMessage: error?['password']?[0],
                  ),
                  const SizedBox(height: 20,),
                  SubmitButton(
                    onTap: signIn,
                    label: "Login",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Not registered yet?",
                   style: TextStyle(fontSize: 13),
                ),
                TextButton(
                  onPressed:(){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const PageLayout(
                          label: "Register",
                          drawer: GuestDrawer(page: "Register"),
                          child: RegisterForm(),
                        ))
                    );
                  }, 
                  child: const Text(
                    "Register Now!",
                    style: TextStyle(fontSize: 13)
                  ),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}