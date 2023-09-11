import 'package:flutter/material.dart';
import 'package:mobile/components/drawer/my_drawer.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  final String pageLabel = "Page Two";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Theme.of(context).primaryColor,

        elevation: 10,

        shadowColor: Theme.of(context).shadowColor,

        title: Text(pageLabel) 

      ),

      drawer: MyDrawer(page: pageLabel,),
      
      body: Center(
        child: Text(
          pageLabel,
          style: const TextStyle(fontSize: 40),  
        ),
      ),
      
    );
  }
}