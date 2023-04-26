import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
      Uint8List? _file;

     void postImage( String uid, String username, String profImage ) async{
       try{

       }catch(err){

       }
     }

  _selectImage(BuildContext context) async{
    return showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          title: const Text('Create a  post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async{
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('Take a photo'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async{
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
              child: const Text('choose from gallery'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('cancel'),
            ),

          ],
        );
      }
    );
  }
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
     return _file == null ? Center(
       child: IconButton(
         icon: const Icon(Icons.upload),
         onPressed: () => _selectImage(context),
       )):
     Scaffold(
       appBar: AppBar(
         backgroundColor: mobileBackgroundColor,
         leading: IconButton(
           onPressed: (){},
           icon: const Icon(Icons.arrow_back),
         ),
         title: const Text('Post to'),
         centerTitle: false,
         actions: [
           TextButton(onPressed: postImage,
           child: const Text('Post',
             style: TextStyle(
             color: Colors.blue,
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),
           )
           )
         ],
       ),
       body: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      user.photoUrl
                  ),
                ),
               SizedBox(
                 width: MediaQuery.of(context).size.width * 0.4,
                 child: TextField(
                   controller: _descriptionController,
                   decoration: const InputDecoration(
                     hintText: 'Write a caption...',
                     border: InputBorder.none,
                   ),
                   maxLines: 8,

                 ),
               ),
               SizedBox(
                 height: 45,
                 width: 45,
                 child: AspectRatio(
                   aspectRatio: 487/451,
                   child: Container(
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: MemoryImage(_file!),
                         fit: BoxFit.fill,
                         alignment: FractionalOffset.topCenter
                       )
                     ),
                   ),
                 ),
               ),
               const Divider()
             ],
           )
         ],
       ),
     );
       //Center(
    //   child: IconButton(
    //     icon: Icon(Icons.upload),
    //     onPressed: () {},
    //   ),
   // );
  }
}
