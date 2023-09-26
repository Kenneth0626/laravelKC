import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobile/components/display/center_loading.dart';
import 'package:mobile/components/display/empty_list_display.dart';
import 'package:mobile/components/display/load_more_display.dart';
import 'package:mobile/components/dialog/token_expired_dialog.dart';
import 'package:mobile/pages/error_loading.dart';
import 'package:mobile/pages/post/post_view.dart';
import 'package:mobile/pages/post/post_view_layout.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

class SeePosts extends StatefulWidget {
  const SeePosts({
    super.key,
    this.isAuthenticated = false,
  });

  final bool isAuthenticated;

  @override
  State<SeePosts> createState() => _SeePostsState();
}

class _SeePostsState extends State<SeePosts> {

  final _scrollController = ScrollController();

  late Future<int> _futurePosts;

  bool _isLastPage = true;
  bool _isLoadingMorePosts = false;

  void _scrollListener() async{

    if(!_isLoadingMorePosts && !_isLastPage && _scrollController.position.pixels == _scrollController.position.maxScrollExtent){ 
      
      _isLoadingMorePosts = true;

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent - 1, 
            duration: const Duration(milliseconds: 50), 
            curve: Curves.fastOutSlowIn
          );
      });

      int state = await Provider.of<PostProvider>(context, listen: false).paginatePost();
      
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent - 1, 
            duration: const Duration(milliseconds: 50), 
            curve: Curves.fastOutSlowIn
          );
      });
      
      if(context.mounted){

        _isLastPage = Provider.of<PostProvider>(context, listen: false).isLastPostPage;

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
              content: Text("Error has occured."),
            )
          );
        }      

      }

      _isLoadingMorePosts = false;

    }
    
  }

  void _reload(){
    setState(() {
      _futurePosts = Provider.of<PostProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  void initState() {
    _futurePosts = Provider.of<PostProvider>(context, listen: false).fetchPosts();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: _futurePosts,

      builder: (context, snapshot){
        if(snapshot.connectionState != ConnectionState.done){
          return const CenterLoading();
        }
        else{
          if(snapshot.data == 3){
            return ErrorLoading(
              onReset: _reload,
            );
          }
          _isLastPage = Provider.of<PostProvider>(context, listen: false).isLastPostPage;
          return Consumer<PostProvider>(

            builder: (context, value, child) {

              if(value.isTokenExpired){
                Provider.of<PostProvider>(context, listen: false).resetProvider();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
                  tokenExpiredDialog(context);
                });
                return const CenterLoading();
              }

              if(value.isLastPostPage){
                _isLastPage = value.isLastPostPage;
              }
        
              final posts = value.posts;
        
              if(posts.isEmpty){
                return EmptyListDisplay(
                  label: "No Posts", 
                  color: Theme.of(context).primaryColor,
                );
              }
        
              return Padding(

                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),

                child: ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  children: [

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {

                        final post = posts[index];

                        return Padding(

                          padding: const EdgeInsets.only(top:10),

                          child: ListTile(
                            tileColor: post.isAuthor ? Theme.of(context).cardColor : Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: post.isAuthor ? Theme.of(context).highlightColor : Theme.of(context).primaryColor,  
                              ),
                              borderRadius: BorderRadius.circular(25)
                            ),
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PostViewLayout(
                                    id: post.id,
                                    child: PostView(
                                      id: post.id,
                                      guestID: post.guestId,
                                    ),
                                  ),
                                ),
                              );
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  post.title,
                                  style: const TextStyle(fontSize: 20),
                                ),

                                Text(
                                  'by ${post.authorUsername}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  'created at ${post.createdAt} ${post.createdAt != post.updatedAt ? "(edited)" : ""}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),

                              ],
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),

                        );

                      }
                    ),
              
                    if(!value.isLastPostPage && !value.isLoadingPosts)
                      const LoadMoreDisplay(),
                    
                    if(value.isLoadingPosts)
                      const CenterLoading(),
                    
                    const SizedBox(height: 40,),
        
                  ],
                ),

              );
              
            },

          );
        }
        
      },
      
    );
  }
}
