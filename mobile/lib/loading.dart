import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/authenticated_drawer.dart';
import 'package:mobile/components/drawer/guest_drawer.dart';
import 'package:mobile/pages/guest/login_form.dart';
import 'package:mobile/pages/page_layout.dart';
import 'package:mobile/pages/user/welcome.dart';
import 'package:mobile/services/token/get_token_service.dart';

class FirstOpen extends StatelessWidget {
  const FirstOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: getTokenService(), 

      builder: (context, snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){
          return  const Scaffold(
            body: Center (
              child: CircularProgressIndicator(),
            ),
          );
        }
        else{
          if(snapshot.data == null) {
            return const PageLayout(
              label: "Login",
              drawer: GuestDrawer(page: "Login"),
              child: LoginForm(),
            );
          }
          else{
            return const PageLayout(
              label: "Home",
              drawer: AuthenticatedDrawer(page: "Home"),
              child: Welcome(),
            );
          }
        }
        
      }

    );
  }
}