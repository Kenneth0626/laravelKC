import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  const NavigationTile({
    super.key,
    required this.label,
    required this.currentPage,
    required this.child,
  });

  final String label;
  final String currentPage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      title : Text(label),

      tileColor: currentPage == label ? Theme.of(context).indicatorColor : Colors.transparent,

      onTap: (){
        if(currentPage != label){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => child,
            )
          );
        }
      },

    );
  }
}