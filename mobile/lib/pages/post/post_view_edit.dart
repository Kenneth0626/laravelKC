import 'package:flutter/material.dart';
import 'package:mobile/components/form/submit_button.dart';
import 'package:mobile/components/post_components/post_edit_field.dart';
import 'package:mobile/components/post_components/post_view_container.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostViewEdit extends StatefulWidget {
  const PostViewEdit({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });

  final int id;
  final String title;
  final String content;

  @override
  State<PostViewEdit> createState() => _PostViewEditState();
}

class _PostViewEditState extends State<PostViewEdit> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _titleValid = true;
  bool _contentValid = true;

  void _checkTitleField(bool value){

    if(_titleValid != !value){
      setState(() {
        _titleValid = !value;
      });
    }
    
  }

  void _checkContentField(bool value){

    if(_contentValid != !value){
      setState(() {
        _contentValid = !value;
      });
    }
    
  }

  void _updatePost() async{

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    int status = await Provider.of<PostProvider>(context, listen: false).patchPost(
      widget.id, _titleController.text, _contentController.text);

    if(status == 1 && context.mounted){
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    if(status == 3 && context.mounted){
      Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error has occured."),
        )
      );
    }

  }

  @override
  void initState(){
    _titleController.text = widget.title;
    _contentController.text = widget.content;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Edit Post"),
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Theme.of(context).shadowColor,
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          
          PostViewContainer(
            child: Column(
              children: [

                PostEditField(
                  label: "Title",
                  controller: _titleController,
                  textState: _checkTitleField,
                ),

                const SizedBox(height: 20,),

                PostEditField(
                  label: "Content",
                  controller: _contentController,
                  textState: _checkContentField,
                ),

                const SizedBox(height: 20,),

                SubmitButton(
                  label: "Save",
                  onTap: _titleValid && _contentValid ? _updatePost : null,
                ),

              ],
            ),
          ),

        ],
      ),
      
    );
  }
}