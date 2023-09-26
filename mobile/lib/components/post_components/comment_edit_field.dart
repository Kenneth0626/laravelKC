import 'package:flutter/material.dart';
import 'package:mobile/components/post_components/comment_edit_options.dart';

class CommentEditField extends StatefulWidget {
  const CommentEditField({
    super.key,
    required this.postId,
    required this.id,
    required this.content,
    required this.onTap,
    required this.controller,
    this.focusNode,
  });

  final int postId;
  final int id;
  final String content;
  final Function(String, String, int, int) onTap;
  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  State<CommentEditField> createState() => _CommentEditFieldState();
}

class _CommentEditFieldState extends State<CommentEditField> {

  bool _isEmpty = false;
  int _textCounter = 0;

  @override
  void initState() {
    _textCounter = widget.controller.text.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: widget.controller,

      focusNode: widget.focusNode,      

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
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          )
        ),
        suffixIcon: CommentEditOptions(
          postId: widget.postId,
          id: widget.id,
          controller: widget.controller,
          onTap: widget.onTap,
          isEmpty: _isEmpty,
        ),
        counterText: '$_textCounter/255',
      ),
      
    );

  }

}