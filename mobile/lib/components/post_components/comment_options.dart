import 'package:flutter/material.dart';

class CommentOptions extends StatefulWidget {
  const CommentOptions({
    super.key,
    required this.postId,
    required this.id,
    required this.content,
    required this.onTap,
  });

  final int postId;
  final int id;
  final String content;
  final Function(String, String, int, int) onTap;

  @override
  State<CommentOptions> createState() => _CommentOptionsState();
}

class _CommentOptionsState extends State<CommentOptions> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(

      itemBuilder: (context) => [
        
        const PopupMenuItem(
          value: "Edit",
          child: Text("Edit"),
        ),

        const PopupMenuItem(
          value: "Delete",
          child: Text("Delete"),
        ),
      
      ],

      onSelected: (value) {
        widget.onTap(value, widget.content, widget.id, widget.postId);
      },

    );
  }
}