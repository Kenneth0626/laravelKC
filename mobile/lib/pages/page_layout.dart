import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.label,
    required this.drawer,
    required this.child,
    this.floatingActionButton,
  });

  final String label;
  final Widget drawer;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(label),
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Theme.of(context).shadowColor,
      ),

      drawer: drawer,
      
      body: Center(
        child: child,
      ),
      
      floatingActionButton: floatingActionButton,

    );
  }
}