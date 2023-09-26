import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/guest_drawer.dart';
import 'package:mobile/pages/guest/login_form.dart';
import 'package:mobile/pages/page_layout.dart';
import 'package:mobile/services/token/delete_token_service.dart';

void tokenExpired(BuildContext context){

  deleteTokenService();
  Navigator.popUntil(context, (predicate) => predicate.isFirst);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const PageLayout(
        label: "Login", 
        drawer: GuestDrawer(page: "Login"), 
        child: LoginForm(),
      ),
    ),
  );

}
