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

  Future<void> likesPost(String postId, String uid, List likes)async {
    try{
      if(likes.contains(uid)){
       await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid])
      });
      }else{
       await  _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    }catch(err){
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<void>postComment(String postId, String uid, String text, String username, String profilePic) async{
    try{
    if(text.isNotEmpty){
      String commentId = const Uuid().v1();
      await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).set({
        'profilePic': profilePic,
        'name': username,
        'uid': uid,
        'text': text,
        'commentId': commentId,
        'datePublished': DateTime.now()

      });
    }else{
      // ignore: avoid_print
      print('Text is empty');
    }
    }catch(err){
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<void> deletePost(String postId) async{
    try{
     await _firestore.collection('posts').doc(postId).delete();
    }catch(err){
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<void> followUser(
      String uid,
      String followId
      ) async{
    try{
      DocumentSnapshot snap = await _firestore.collection("users").doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)){
        await _firestore.collection("users").doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection("users").doc(uid).update({
          'followers': FieldValue.arrayRemove([followId])
        });
      }else{
        await _firestore.collection("users").doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection("users").doc(uid).update({
          'followers': FieldValue.arrayUnion([followId])
        });
      }
    }catch(err){
      // ignore: avoid_print
      print(err.toString());
    }

  }


}