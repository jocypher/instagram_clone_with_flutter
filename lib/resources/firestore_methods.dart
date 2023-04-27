import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profImage,
      ) async{
    String res = "some error occurred";
    try{
        String photoUrl =  await StorageMethods().uploadImageToStorage('posts', file, true);
        String postId = const Uuid().v1();
        Post post = Post(
            description: description,
            uid: uid,
            username: username,
            datePublished: DateTime.now(),
            postId: postId,
            postUrl: photoUrl,
            profImage: profImage,
            likes: []);
        // uploading to firestore
      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    }catch(err){
      res = err.toString();
    }
    return res;
  }

}