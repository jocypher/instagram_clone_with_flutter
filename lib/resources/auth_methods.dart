import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      if(email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || username.isNotEmpty || file != null){
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(credential.user!.uid);
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'username' : username,
          'email': email,
          'uid': credential.user!.uid,
          'bio': bio,
          'followers': [],
          'following' : []
        });
        res = 'successful';
      }
    }catch(err){
      res = err.toString();
    }
    return res;
  }
}