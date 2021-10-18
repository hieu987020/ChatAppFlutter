import 'dart:developer';

import 'package:chat_app/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      log("Account create successfully");
      await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
        "name": name,
        "email": email,
        "status": "Unavailable",
      });
      return user;
    } else {
      log("Account create failed");
      return user;
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      log("Login successfully");
      return user;
    } else {
      log("Login failed");
      return user;
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  } catch (e) {
    log("error");
  }
}
