import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class FireStoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String description,
      Uint8List file
      ) async{
    String res = "some error occurred";
    try{
        String photoUrl =  await StorageMethods().uploadImageToStorage('posts', file, true);
    }catch(err){

    }
  }
}