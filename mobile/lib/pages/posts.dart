import 'package:flutter/material.dart';
import 'package:mobile/components/function/token_expired.dart';
import 'package:mobile/services/authenticate_service.dart';

class SeePosts extends StatefulWidget {
  const SeePosts({
    super.key,
    this.isAuthenticated = false,
  });

  final bool isAuthenticated;

  @override
  State<SeePosts> createState() => _SeePostsState();
}

class _SeePostsState extends State<SeePosts> {
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
                "Error Loading Posts.",
                style: TextStyle(fontSize: 40),
              ),
            );
          }
          else{

            if(widget.isAuthenticated == true && snapshot.data == 401){

              WidgetsBinding.instance.addPostFrameCallback((_) { 
                tokenExpired(context);
              });

              return const SizedBox.shrink();

            }

            return const Center(
              child: Text(
                "See Posts",
                style: TextStyle(fontSize: 40),
              )
            ); 
          }
        }
      },
    );
  }
}