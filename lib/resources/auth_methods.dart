import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String>SignUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file
}) async{
    String res = "an error occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || username.isNotEmpty){
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(credential.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        await _firestore.collection("users").doc(credential.user!.uid).set({
          'username' : username,
          'email': email,
          'uid': credential.user!.uid,
          'bio': bio,
          'followers': [],
          'following' : [],
          'photoUrl': photoUrl
        });
        res = 'successful';
      }
    } catch(err){
      res = err.toString();
    }
    return res;
  }

  Future<String>LoginUser({required String email, required String password})async{
    String res= 'an error occurred';
    try{
      if(email.isNotEmpty || password.isNotEmpty){
         await _auth.signInWithEmailAndPassword(email: email, password: password);
         res= 'success';
        }else{
        res = 'please enter all fields';
      }
    }catch(err){
      res = err.toString();
    }
    return res;
  }
}