import 'package:flutter/material.dart';

class PostEditField extends StatefulWidget {
  const PostEditField({
    super.key,
    required this.label,
    required this.controller,
    required this.textState,
  });

  final String label;
  final TextEditingController controller;
  final Function(bool) textState;

  @override
  State<PostEditField> createState() => _PostEditFieldState();
}

class _PostEditFieldState extends State<PostEditField> {

  int _textCounter = 0;

  @override
  void initState() {
    _textCounter = widget.controller.text.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          maxLength: 255,
          onChanged:(value) {
            widget.textState(value.isEmpty);
            setState(() {
              _textCounter = value.length;
            });
          },
          decoration: InputDecoration(
            counterText: '$_textCounter/255'
          ),
        ),

      ],
      
    );
  }
}