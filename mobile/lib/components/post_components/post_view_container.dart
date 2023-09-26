import 'package:flutter/material.dart';

class PostViewContainer extends StatefulWidget {
  const PostViewContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PostViewContainer> createState() => _PostViewContainerState();
}

class _PostViewContainerState extends State<PostViewContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
        bottom: 15,
      ),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20)
      ),

      child: widget.child,

    );
  }
}