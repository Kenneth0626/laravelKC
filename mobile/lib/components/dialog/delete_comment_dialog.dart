import 'package:flutter/material.dart';

void deleteCommentDialog(BuildContext context, int id, Function(int) func) async{

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text("Delete Comment"),
      content: const Text("Are you sure to delete this comment?"),
      actions: [

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            func(id);
          }, 
          child: const Text("Confirm"),                     
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: const Text("Cancel"),                        
        ),
        
      ],
    ),
  );
  
}