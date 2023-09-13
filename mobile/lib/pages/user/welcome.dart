import 'package:flutter/material.dart';
import 'package:mobile/components/function/token_expired.dart';
import 'package:mobile/services/authenticate_service.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authenticateService(), 
      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return  const Center(child: CircularProgressIndicator());
        }
        else{
          if (snapshot.hasError){
            return const Center(
              child: Text(
                "Error Loading User.",
                style: TextStyle(fontSize: 40),
              ),
            );
          }
          else{

            if(snapshot.data == 401){

              WidgetsBinding.instance.addPostFrameCallback((_) { 
                tokenExpired(context);
              });

              return const SizedBox.shrink();

            }

            return Center(
              child: Text(
                'Welcome ${snapshot.data}!',
                style: const TextStyle(fontSize: 20),
              )
            ); 

          }
        }
      },
    );
  }
}