import 'package:flutter/material.dart';
import 'package:mobile/components/form/submit_button.dart';
import 'package:mobile/components/display/center_loading.dart';
import 'package:mobile/components/post_components/post_edit_field.dart';
import 'package:mobile/components/post_components/post_view_container.dart';
import 'package:mobile/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  bool _titleValid = false;
  bool _contentValid = false;

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

  void _storePost() async{

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return const CenterLoading();
      }
    );

    int status = await Provider.of<PostProvider>(context, listen: false).storePost(
      _titleController.text, _contentController.text);

    if(status == 1 && context.mounted){
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    if(status == 3 && context.mounted){
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error has occured."),
        )
      );
    }
   
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
        title: const Text("Create Post"),
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
                  label: "Create Post",
                  onTap: _titleValid && _contentValid ? _storePost : null,
                ),

              ],
            ),
          ),

        ],
      ),
      
    );
  }
}