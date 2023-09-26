import 'package:flutter/material.dart';
import 'package:mobile/components/dialog/token_expired.dart';
import 'package:mobile/pages/error_loading.dart';
import 'package:mobile/services/auth/get_user_service.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: getUserService(), 

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
            if(snapshot.data == -2){
              WidgetsBinding.instance.addPostFrameCallback((_) { 
                tokenExpired(context);
              });
              return const SizedBox.shrink();
            }
            else if(snapshot.data == -1){
              return ErrorLoading(
                onReset: () {
                  setState(() {});
                },
              );
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