import 'package:flutter/material.dart';

class AddComment extends StatefulWidget {
  const AddComment({
    super.key,
    required this.postId,
    required this.controller,
    required this.onTap,
    this.focusNode,
    this.isUnfocused = false,
  });

  final int postId;
  final TextEditingController controller;
  final Function(int, String) onTap;
  final FocusNode? focusNode;
  final bool isUnfocused;

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {

  bool _isEmpty = true;
  int _textCounter = 0;

  @override
  Widget build(BuildContext context) {
    
    if(widget.isUnfocused){
      widget.controller.clear();
      setState((){
        _isEmpty = true;
        _textCounter = 0;
      });
    }
    
    return TextField(
      
      controller: widget.controller,

      focusNode: widget.focusNode,

      style: const TextStyle(
        fontSize: 13,
      ),

      keyboardType: TextInputType.multiline,

      maxLines: null,

      maxLength: 255,

      onChanged:(value) {
        setState(() {
          _isEmpty = value.isEmpty;
          _textCounter = value.length;
        });
      },

      decoration: InputDecoration(
        hintText: "add a comment...",
        suffixIcon: _isEmpty ? 
          null : 
          IconButton(
            onPressed: () {
              String text = widget.controller.text;
              widget.controller.clear();
              setState(() {
                _isEmpty = true;
              });
              widget.onTap(widget.postId, text);
            }, 
            icon: const Icon(Icons.send),
          ),
        counterText: '$_textCounter/255',
      ),
      
    );

  }
  
}