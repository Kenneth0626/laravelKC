import 'package:flutter/material.dart';
import 'package:mobile/components/post_components/comment_edit_field.dart';
import 'package:mobile/components/post_components/comment_options.dart';
import 'package:mobile/models/Comment.dart';

class CommentTile extends StatefulWidget {
  const CommentTile({
    super.key,
    required this.isOwner,
    required this.comment,
    required this.isSelected,
    required this.onTap,
    required this.controller,
    this.focusNode,
    this.isDeleting = false,
    this.tempUpdatedContent,
  });

  final bool isOwner;
  final Comment comment;
  final bool isSelected;
  final Function(String, String, int, int) onTap;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool isDeleting;
  final String? tempUpdatedContent;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {

  String commentStatusSpan(bool isSelected, bool isUpdating, bool isDeleting, String createdAt, String updatedAt){
  
    if(isSelected){
      if(isUpdating){
        return "updating...";
      }
      else if(isDeleting){
        return "removing...";
      }
    }

    return 'commented on $createdAt ${createdAt != updatedAt ? "(edited)" : ""}';
    
  }

  String commentNewTemp(bool isSelected, String? tempText, String text){
    
    if(tempText != null && isSelected){
      return tempText;
    }

    return text;

  }

  @override
  Widget build(BuildContext context) {
    return Material(

      color: Theme.of(context).primaryColorLight,

      child: Padding(
        padding: const EdgeInsets.only(top: 5,),
        child: ListTile(
          tileColor: widget.isOwner ? Theme.of(context).cardColor : Theme.of(context).disabledColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: widget.isOwner ? Theme.of(context).highlightColor : Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(25)
          ),
          title: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
      
                TextSpan(
                  text: '${widget.comment.ownerUsername} ',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  )
                ),
      
                TextSpan(
                  text: commentStatusSpan(
                    widget.isSelected, widget.tempUpdatedContent != null, widget.isDeleting, widget.comment.createdAt, widget.comment.updatedAt),
                  style: const TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
      
              ],
            ),
          ),
          subtitle: widget.isSelected && widget.tempUpdatedContent == null && !widget.isDeleting ? 
            CommentEditField(
              id: widget.comment.id,
              postId: widget.comment.postId,
              content: widget.comment.content,
              controller: widget.controller,
              focusNode: widget.focusNode,
              onTap: widget.onTap,
            ) : 
            Text( commentNewTemp(widget.isSelected, widget.tempUpdatedContent, widget.comment.content)),
          trailing: widget.isOwner ?  
            ( widget.isSelected ?
              null :
              CommentOptions(
                id: widget.comment.id,
                postId: widget.comment.postId,
                content: widget.comment.content, 
                onTap: widget.onTap,
              )
            ) : null,
        ),
      ),
      
    );
  }
}