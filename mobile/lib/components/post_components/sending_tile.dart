import 'package:flutter/material.dart';

class SendingTile extends StatefulWidget {
  const SendingTile({
    super.key,
    required this.content,

  });

  final String content;

  @override
  State<SendingTile> createState() => _SendingTileState();
}

class _SendingTileState extends State<SendingTile> {
  @override
  Widget build(BuildContext context) {
    return Material(

      color: Theme.of(context).primaryColorLight,

      child: Padding(
        padding: const EdgeInsets.only(top: 5,),
        child: ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(25)
          ),
          title: const Text(
            "posting...",
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic
            ),
          ),
          subtitle: Text(widget.content),
        ),
      ),
      
    );
  }
}