import 'package:flutter/material.dart';

class CommentEditOptions extends StatelessWidget {
  const CommentEditOptions({
    super.key,
    required this.postId,
    required this.id,
    required this.controller,
    required this.onTap,
    this.isEmpty = false,
  });

  final int postId;
  final int id;
  final TextEditingController controller;
  final Function(String, String, int, int) onTap;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      mainAxisSize: MainAxisSize.min,

      children: [

        if(!isEmpty)
          IconButton(
            onPressed: (){
              if(!isEmpty){
                onTap("Save", controller.text, id, postId);
              }
            }, 
            icon: const Icon(Icons.save),
            color: Colors.green[700],
          ),
        
        IconButton(
          onPressed: (){
            onTap("Cancel", "", 0, postId);
          }, 
          icon: const Icon(Icons.cancel),
          color: Colors.red[600],
        ),
        
      ],

    );
  }
}