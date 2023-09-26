import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/button_tile.dart';
import 'package:mobile/components/drawer/guest_drawer.dart';
import 'package:mobile/components/drawer/navigation_tile.dart';
import 'package:mobile/components/post_components/floating_add_post.dart';
import 'package:mobile/pages/guest/login_form.dart';
import 'package:mobile/pages/page_layout.dart';
import 'package:mobile/pages/post/see_posts.dart';
import 'package:mobile/pages/user/welcome.dart';
import 'package:mobile/services/auth/logout_service.dart';

class AuthenticatedDrawer extends StatelessWidget {
  const AuthenticatedDrawer({
    super.key,
    required this.page
  });

  final String page;

  @override
  Widget build(BuildContext context) {

    void logout() async{

      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      );
      
      int status = await logoutService();

      if(status == 200 && context.mounted){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PageLayout(
              label: "Login",
              drawer: GuestDrawer(page: "Login"),
              child: LoginForm(),
            ))
        );
      }

      if(status != 200 && context.mounted){
        Navigator.of(context, rootNavigator: true).pop();
      }

    }
    
    return Drawer(

      child: Column(
        children: [

          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
            ),
          ),

          NavigationTile(
            label: "Home", 
            currentPage: page,
            child: const PageLayout(
              label: "Home",
              drawer: AuthenticatedDrawer(page: "Home"),
              child: Welcome(),
            ),
          ),

          NavigationTile(
            label: "See Posts", 
            currentPage: page,
            child: const PageLayout(
              label: "See Posts",
              drawer: AuthenticatedDrawer(page: "See Posts"),
              floatingActionButton: FloatingAddPost(),
              child: SeePosts(isAuthenticated: true,),
            ),
          ),

          ButtonTile(
            label: "Logout", 
            onTap: logout,
          ),
          
        ],
      ),

    );
  }
}