import 'package:flutter/material.dart';
import 'package:mobile/components/display/center_loading.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

void deletePostConfirm(BuildContext context, int postID) async{

  showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context){
      return const CenterLoading();
    }
  );

  int status = await Provider.of<PostProvider>(context, listen: false).deletePost(postID);

  if(status == 1 && context.mounted){
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  else if(status == 3 && context.mounted){
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Error has occured."),
      )
    );
  }

}