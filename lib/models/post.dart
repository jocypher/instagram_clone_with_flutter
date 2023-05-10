
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;
  final String postId;
  final String postUrl;
  final String profImage;
  // ignore: prefer_typing_uninitialized_variables
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.postId,
    required this.postUrl,
    required this.profImage,
    required this.likes
  });

  Map<String, dynamic> toJson() => {
    'username' : username,
    'datePublished': datePublished,
    'description': description,
    'uid': uid,
    'postId': postId,
    'postImage': profImage,
    'postUrl' : postUrl,
    'likes': likes
  };

  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      datePublished: snapshot['datePublished'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['postImage'],
      likes: snapshot['likes']

    );
  }

}