import 'package:flutter/material.dart';
import 'package:mobile/components/dialog/delete_post_confirm.dart';

void deletePostDialog(BuildContext context, int postID) async{

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: const Text("Delete Post"),
      content: const Text("Are you sure to delete this post?"),
      actions: [

        TextButton(
          onPressed: () {
            deletePostConfirm(context, postID);
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