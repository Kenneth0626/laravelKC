import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/navigation_tile.dart';
import 'package:mobile/pages/page_one.dart';
import 'package:mobile/pages/page_three.dart';
import 'package:mobile/pages/page_two.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
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

            label: "Page One", 

            currentPage: page,

            child: const PageOne(),

          ),

          NavigationTile(

            label: "Page Two", 

            currentPage: page,

            child: const PageTwo(),

          ),

          NavigationTile(

            label: "Page Three", 

            currentPage: page,

            child: const PageThree(),

          ),

        ],

      ),

    );
  }
}