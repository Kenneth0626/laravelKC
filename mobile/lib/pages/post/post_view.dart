import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/components/dialog/delete_comment_dialog.dart';
import 'package:mobile/components/display/center_loading.dart';
import 'package:mobile/components/display/empty_list_display.dart';
import 'package:mobile/components/display/load_more_display.dart';
import 'package:mobile/components/post_components/add_comment.dart';
import 'package:mobile/components/post_components/comment_tile.dart';
import 'package:mobile/components/post_components/post_view_container.dart';
import 'package:mobile/components/post_components/sending_tile.dart';
import 'package:mobile/pages/error_loading.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostView extends StatefulWidget {
  const PostView({
    super.key,
    required this.id,
    required this.guestID,
  });

  final int id;
  final int? guestID;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  final _addCommentController = TextEditingController();
  final _commentController = TextEditingController();

  final _commentFocus = FocusNode();
  final _addCommentFocus = FocusNode();

  final _scrollController = ScrollController();

  late Future<int> _futureComments;
  dynamic _postInfo;

  bool _isLoadingMoreComments = false;
  bool _isLastPage = true;
  bool _isEditing = false;

  void _addComment(int postID, String content) async {

    int state = await Provider.of<PostProvider>(context, listen: false).storeComment(postID, content);

    _addCommentController.clear();

    if(state == 3 && context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error has occurred."),
        )
      );
    }

  }

  void _commentOption(String value, String content, int commentID, int postID) async {

    if(value == "Edit"){
      _commentFocus.requestFocus();
      _commentController.text = content;
      _addCommentController.clear();
      Provider.of<PostProvider>(context, listen: false).setTargetID(commentID);
      _isEditing = true;
    }

    if(value == "Cancel"){
      _commentController.clear();
      Provider.of<PostProvider>(context, listen: false).setTargetID(0);
      _isEditing = false;
    }

    if(value == "Save"){
      _isEditing = false;
      int state = await Provider.of<PostProvider>(context, listen: false).patchComment(postID, commentID, content);
      _commentController.clear();
      if(state == 3 && context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error updating comment."),
          )
        );
      }
    }

    if(value == "Delete" && context.mounted){
      deleteCommentDialog(context, commentID, _removeComment);
    }
    
  }

  void _commentFieldFocus(){

    if(_addCommentFocus.hasFocus && _isEditing){
      Provider.of<PostProvider>(context, listen: false).setTargetID(0);
      _commentController.clear();
      _isEditing = false;
    }

  }

  void _scrollListener() async{

    if(!_isLoadingMoreComments && !_isLastPage && _scrollController.position.pixels == _scrollController.position.maxScrollExtent){     
      
      _isLoadingMoreComments = true;

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent - 1, 
            duration: const Duration(milliseconds: 50), 
            curve: Curves.fastOutSlowIn
          );
      });

      int state = await Provider.of<PostProvider>(context, listen: false).paginateComments(widget.id);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent - 1, 
            duration: const Duration(milliseconds: 50), 
            curve: Curves.fastOutSlowIn
          );
      });

      if(context.mounted){
        
        if(!_isLastPage){
          _isLastPage = Provider.of<PostProvider>(context, listen: false).isLastCommentPage;
        }

        if(state == 1 && _isLastPage){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This is the last page."),
            )
          );
        }

        else if(state == 3){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error loading comments."),
            )
          );
        }
      }

      _isLoadingMoreComments = false;

    }
    
  }

  void _removeComment(int commentID) async{

    int status = await Provider.of<PostProvider>(context, listen: false).deleteComment(commentID, widget.id);

    if(context.mounted){
      if(status == 3){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error has occured."),
          )
        );
      }
      if(!_isLastPage){
        _isLastPage = Provider.of<PostProvider>(context, listen: false).isLastCommentPage;
      }
    } 

  }

  void _reload(){
    setState(() {
      _futureComments = Provider.of<PostProvider>(context, listen: false).fetchComments(widget.id);
    });
  }

  @override
  void initState() {
    _futureComments = Provider.of<PostProvider>(context, listen: false).fetchComments(widget.id);
    _postInfo = Provider.of<PostProvider>(context, listen: false).getPost(widget.id);
    _addCommentFocus.addListener(_commentFieldFocus);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _addCommentController.dispose();
    _commentController.dispose();
    _addCommentFocus.removeListener(_commentFieldFocus);
    _addCommentFocus.dispose();
    _commentFocus.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(

      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

      controller: _scrollController,

      children: [

        PostViewContainer(
          child: Consumer<PostProvider>(
            builder:(context, value, child) {

              final post = value.getPost(widget.id);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
              
                  Text(
                    'by ${post.authorUsername}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  Text(
                    'created at ${post.createdAt} ${post.createdAt != post.updatedAt ? "(edited)" : ""}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              
                  const Divider(
                    color: Colors.black,
                  ),
              
                  Text(post.content),
              
                  const Divider(
                    color: Colors.black,
                  ),
                
                ],
              );

            },
          ),
        ),

        if(widget.guestID != null)
          PostViewContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
    
                const Text("Add Comment"),
    
                Consumer<PostProvider>(
                  builder:(context, value, child) {
                    return AddComment(
                      postId: _postInfo.id,
                      controller: _addCommentController,
                      focusNode: _addCommentFocus,
                      isUnfocused: value.targetID != 0,
                      onTap: _addComment,
                    );
                  },
                ),
    
              ],
            )
          ),
  
        PostViewContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text("Comments"),

              FutureBuilder(
                future: _futureComments,
                builder: (context, snapshot) {
                  if(snapshot.connectionState != ConnectionState.done){
                    return const CenterLoading();
                  }
                  else{
                    if(snapshot.data == 3){
                      return ErrorLoading(
                        onReset: _reload,
                      );
                    }
                    _isLastPage = Provider.of<PostProvider>(context, listen: false).isLastCommentPage;
                    return Consumer<PostProvider>(

                      builder: (context, value, child) {

                        if(value.comments.isEmpty && value.newCommentTemp == null){
                          return EmptyListDisplay(
                            label: "No Comments", 
                            color: Theme.of(context).indicatorColor,
                          );
                        }
                        
                        return Column(

                          children: [

                            if(value.newCommentTemp != null)
                              SendingTile(content: value.newCommentTemp!,),
                            
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),  
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,                  
                              itemCount: value.comments.length,
                              itemBuilder: (context, index){
                                final comment = value.comments[index];
                                return CommentTile(
                                  isOwner: _postInfo.guestId == comment.ownerId,
                                  comment: comment,
                                  isSelected: comment.id == value.targetID,
                                  onTap: _commentOption,
                                  controller: _commentController,
                                  focusNode: _commentFocus,
                                  isDeleting: value.isDeletingComment,
                                  tempUpdatedContent: value.patchCommentTemp,
                                );
                              },
                            ),

                            if(!value.isLastCommentPage && !value.isLoadingComments)
                              const LoadMoreDisplay(),

                            if(value.isLoadingComments)
                              const CenterLoading(),

                          ],

                        );
                      },

                    );
                  }
                },
              ),

            ],
          )
        ),
      ],

    );
  }
}