import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/navigation_tile.dart';
import 'package:mobile/pages/guest/login_form.dart';
import 'package:mobile/pages/guest/register_form.dart';
import 'package:mobile/pages/page_layout.dart';
import 'package:mobile/pages/post/see_posts.dart';
// import 'package:mobile/pages/pageNumber/page_one.dart';
// import 'package:mobile/pages/pageNumber/page_three.dart';
// import 'package:mobile/pages/pageNumber/page_two.dart';

class GuestDrawer extends StatelessWidget {
  const GuestDrawer({
    super.key,
    required this.page
  });

  final String page;

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: [

          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
            ),
          ),

          NavigationTile(
            label: "Login", 
            currentPage: page,
            child: const PageLayout(
              label: "Login",
              drawer: GuestDrawer(page: "Login"),
              child: LoginForm(),
            ),
          ),

          NavigationTile(
            label: "Register", 
            currentPage: page,
            child: const PageLayout(
              label: "Register",
              drawer: GuestDrawer(page: "Register"),
              child: RegisterForm(),
            ),
          ),

          NavigationTile(
            label: "See Posts", 
            currentPage: page,
            child: const PageLayout(
              label: "See Posts",
              drawer: GuestDrawer(page: "See Posts"),
              child: SeePosts(),
            ),
          ),

        ],
      ),

    );
  }
}