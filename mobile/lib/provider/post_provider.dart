import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/Comment.dart';
import 'package:mobile/models/Post.dart';
import 'package:mobile/services/comment/delete_comment_service.dart';
import 'package:mobile/services/post/delete_post_service.dart';
import 'package:mobile/services/comment/get_comments_service.dart';
import 'package:mobile/services/post/get_posts_service.dart';
import 'package:mobile/services/comment/patch_comment_service.dart';
import 'package:mobile/services/post/patch_post_service.dart';
import 'package:mobile/services/comment/store_comment_service.dart';
import 'package:mobile/services/post/store_post_service.dart';

class PostProvider extends ChangeNotifier {

  bool isTokenExpired = false;

  List<Post> _posts = [];
  bool isLoadingPosts = false;
  bool errorLoadingPosts = false;
  bool isLastPostPage = true;

  List<Comment> _comments = [];
  bool isLoadingComments = false;

  bool isDeletingComment = false;
  bool isLastCommentPage = true;
  
  int _postPage = 1;
  int _commentPage = 1;

  int _targetID = 0;
  String? newCommentTemp;
  String? patchCommentTemp;
  String _valueState = "Post";
  
  void setTargetID(int commentID){
    _targetID = commentID;
    notifyListeners();
  }

  List<Post> get posts => _posts;
  List<Comment> get comments => _comments;
  int get targetID => _targetID;
  String get valueState => _valueState;

  dynamic getPost(int id){
    
    int index = _posts.indexWhere((post) => post.id == id);

    if(index < 0){
      return null;
    }

    return _posts[index];

  }

  void resetProvider(){

    isTokenExpired = false;

    _posts.clear();
    isLoadingPosts = false;
    errorLoadingPosts = false;
    isLastPostPage = true;

    _comments.clear();
    isLoadingComments = false;

    isDeletingComment = false;
    isLastCommentPage = true;

    _postPage = 1;
    _commentPage = 1;

    _targetID = 0;
    newCommentTemp = null;
    patchCommentTemp = null;
    _valueState = "Post";
    
  }

  Future<int> fetchPosts() async {

    _valueState = "Post";
    _posts.clear();
    _postPage = 1;
    isTokenExpired = false;
    errorLoadingPosts = false;
    isLoadingPosts = false;
    isLastPostPage = true; 

    int res;

    dynamic response = await getPostsService(_postPage);
    
    if(response is List<Post>){
      _posts = response;
      isLastPostPage = _posts.length < 10;
      res = 1;
    }

    else if(response == -2){
      isTokenExpired = true;
      res = 2;
    }

    else{
      errorLoadingPosts = true;
      res = 3;
    }

    return res;

  }

  Future<int> storePost(String title, String content) async {

    dynamic response = await storePostService(jsonEncode({
      "title": title,
      "content": content,
    }));

    if(response is! int){
      _posts.insert(0, response);
      notifyListeners();
      return 1;
    } 
    
    else if(response == -2){
      isTokenExpired = true;
      notifyListeners();
      return 2;
    }
    
    else{
      return 3;
    }

  }

  Future<int> patchPost(int postID, String title, String content) async {

    dynamic response = await patchPostService(postID, jsonEncode({
      "title": title,
      "content": content,
    }));

    if(response is! int){
      
      int postIndex = _posts.indexWhere((post) => post.id == postID);
      
      _posts[postIndex].title = response['title'];
      _posts[postIndex].content = response['content'];
      notifyListeners();

      return 1;

    }

    else if(response == -2){
      isTokenExpired = true;
      notifyListeners();
      return 2;
    }
    
    else{
      return 3;
    }

  }

  Future<int> deletePost(int postID) async {

    int response = await deletePostService(postID);

    if(response == 204){
      _posts.removeWhere((post) => post.id == postID);

      if(_postPage >= 1){
        _postPage--;
      }

      notifyListeners();
      return _posts.length < 10 ? await paginatePost() : 1;
    }
    
    else if(response == -2){
      isTokenExpired = true;
      notifyListeners();
      return 2;
    }

    else{
      return 3;
    }

  }
  
  Future<int> paginatePost() async {
    
    int res = 0;

    if(!isLastPostPage){

      _postPage++;

      isLoadingPosts = true;
      notifyListeners();

      dynamic response = await getPostsService(_postPage);

      if(response is List<Post>){
        
        if(response.length < 10){
          isLastPostPage = true;
        }

        if(response.isNotEmpty){
          List<Post> newList = _posts + response;
          _posts = newList.toSet().toList();
        }
        
        res = 1;

      }

      else if (response == -2){
        isTokenExpired = true;
        res = 2;
      }
      
      else{
        res = 3;
      }

    }

    res = res == 0 ? 1 : res;

    isLoadingPosts = false;
    notifyListeners();

    return res;

  }

  Future<int> fetchComments(int postID) async {

    int res;

    _comments.clear();
    _commentPage = 1;
    isTokenExpired = false;
    isLoadingComments = false;
    isLastCommentPage = true;
    
    _targetID = 0;
    newCommentTemp = null;
    patchCommentTemp = null;

    dynamic response = await getCommentsService(postID, _commentPage);

    if(response is List<Comment>){
      _comments = response;
      isLastCommentPage = _comments.length < 10;
      res = 1;
    }

    else if(response == -2){
      isTokenExpired = true;
      res = 2;
    }
    else{
      res = 3;
    }
    
    return res;

  }

  Future<int> storeComment(int postID, String content) async {
    
    int res;

    newCommentTemp = content;
    notifyListeners();

    dynamic response = await storeCommentService(postID, jsonEncode({
      "content": content,
    }));

    if(response is! int){
      _comments.insert(0, response);
      res = 1;
    } 
    
    else if(response == -2){
      isTokenExpired = true;
      res = 2;
    }
    
    else{
      res = 3;
    }

    newCommentTemp = null;
    notifyListeners();

    return res;

  }

  Future<int> patchComment(int postID, int commentID, String content) async {

    int res;

    patchCommentTemp = content;
    notifyListeners();

    dynamic response = await patchCommentService(postID, jsonEncode({
      "id": commentID,
      "content": content,
    }));

    if(response is! int){
      
      int commentIndex = _comments.indexWhere((comment) => comment.id == commentID);
      
      _comments[commentIndex].content = response['content'];
      _comments[commentIndex].updatedAt = response['updated_at'];

      res = 1;

    }

    else if(response == -2){
      isTokenExpired = true;
      res = 2;
    }
    
    else{
      res = 3;
    }

    patchCommentTemp = null;
    _targetID = 0;
    notifyListeners();

    return res;

    
  }

  Future<int> deleteComment(int commentID, int postID) async {

    int res;

    _targetID = commentID;
    isDeletingComment = true;
    notifyListeners();

    int response = await deleteCommentService(commentID);

    if(response == 204){
      _comments.removeWhere((comment) => comment.id == commentID);

      if(_commentPage >= 1){
        _commentPage--;
      }

      res = _comments.length < 10 ? await paginateComments(postID) : 1;

    }

    else if(response == -2){
      isTokenExpired = true;
      res = 2;
    }

    else{
      res = 3;
    }
    
    isDeletingComment = false;
    _targetID = 0;
    notifyListeners();

    return res;

  }

  Future<int> paginateComments(int postID) async {
    
    int res = 0;

    isLoadingComments = true;
    notifyListeners();

    if(!isLastCommentPage){

      _commentPage++;

      dynamic response = await getCommentsService(postID, _commentPage);      

      if(response is List<Comment>){

        if(response.length < 10){
          isLastCommentPage = true;
        }

        if(response.isNotEmpty){
          List<Comment> newList = _comments + response;
          _comments = newList.toSet().toList();
        }

        res = 1;

      }

      else if (response == -2){
        isTokenExpired = true;
        res = 2;
      }
      
      else{
        res = 3;
      }

    }

    res = res == 0 ? 1 : res;

    isLoadingComments = false;
    notifyListeners();

    return res;
    
  }
  
}