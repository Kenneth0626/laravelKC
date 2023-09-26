import 'package:flutter/material.dart';
import 'package:mobile/components/dialog/delete_post_dialog.dart';
import 'package:mobile/components/display/post_not_found.dart';
import 'package:mobile/pages/post/post_view_edit.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostViewLayout extends StatefulWidget {
  const PostViewLayout({
    super.key,
    required this.id,
    required this.child,
  });

  final int id;
  final Widget child;

  @override
  State<PostViewLayout> createState() => _PostViewLayoutState();
}

class _PostViewLayoutState extends State<PostViewLayout> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(

      builder:(context, value, child) {
        dynamic post = value.getPost(widget.id);
        if(post == null){
          return const PostNotFound();
        }
        return Scaffold(
          
          appBar: AppBar(
            title: Text(post.title),
            elevation: 10,
            backgroundColor: Theme.of(context).primaryColor,
            shadowColor: Theme.of(context).shadowColor,
            actions: post.isAuthor ? [ 
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PostViewEdit(
                        id: post.id,
                        title: post.title,
                        content: post.content,
                      ),
                    ),
                  );
                }, 
                icon: Icon(
                  Icons.edit,
                  color: Colors.green[700],
                  size: 35,
                ),
              ),
              IconButton(
                onPressed: () => deletePostDialog(context, post.id), 
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[600],
                  size: 35,
                ),
                
              ),
            ] : null,
          ),
      
          body: Center(
            child: widget.child,
          ),
          
        );
      },

    );
  }
}