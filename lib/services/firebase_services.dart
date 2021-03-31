import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseServices{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {

    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference ProductID = FirebaseFirestore
      .instance
      .collection("Users").doc(FirebaseAuth.instance.currentUser.uid).collection("Cart");



  final CollectionReference productsRef = FirebaseFirestore
      .instance
      .collection("Products");

  final CollectionReference usersRef = FirebaseFirestore
      .instance
      .collection("Users");




}