import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

  // usuário atual

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User firebaseUser;
  Map<String, dynamic> userData = {};

  bool isLoading = false;

  void signUp({required Map <String, dynamic> userData, required String pass, 
                required VoidCallback onSuccess, required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: userData["email"],
       password: pass
       ).then((user) async{
        firebaseUser = user.user!;

        await _saveUserData(userData);

        onSuccess();
        isLoading = false;
        notifyListeners();

       }).catchError((e){
        onFail();
        isLoading = false;
        notifyListeners();
        });
       }

  
    // cadastrar usuário

  void signIn() {
    // logar usuário
  }

  void recoverPassword() {
    // recuperar senha
  }

  void signOut() {
    // deslogar usuário
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .set(userData);
  }

}   