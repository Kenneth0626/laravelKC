import 'package:flutter/material.dart';
import 'package:mobile/pages/post/post_create.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

class FloatingAddPost extends StatelessWidget {
  const FloatingAddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(

      builder: (context, value, child) {
        return FloatingActionButton(

          onPressed: () {
            if(!value.isLoadingPosts && !value.errorLoadingPosts){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostCreate(),
                ),
              );
            }
          },
      
          tooltip: 'Create Post',
      
          child: const Icon(Icons.add),
          
        );
      },
      
    );
  }
}