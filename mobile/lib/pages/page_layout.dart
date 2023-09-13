import 'package:flutter/material.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({
    super.key,
    required this.label,
    required this.drawer,
    required this.child,
  });

  final String label;
  final Widget drawer;
  final Widget child;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.label),
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Theme.of(context).shadowColor,
      ),

      drawer: widget.drawer,
      
      body: Center(
        child: widget.child,
      ),
      
    );
  }
}