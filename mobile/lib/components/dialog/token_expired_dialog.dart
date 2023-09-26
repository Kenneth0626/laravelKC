import 'package:flutter/material.dart';
import 'package:mobile/components/dialog/token_expired.dart';

void tokenExpiredDialog(BuildContext context) async{

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text("Token Expired"),
      content: const Text("Your token has expired. Please Login Again."),
      actions: [

        TextButton(
          onPressed: () {
            tokenExpired(context);
          }, 
          child: const Text("ok"),                     
        ),
        
      ],
    ),
  );
  
}