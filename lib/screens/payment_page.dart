import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/confirm.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'package:e_bookstore/screens/size_config.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:e_bookstore/widgets/custom_button.dart';
import 'package:e_bookstore/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;


import 'constants.dart';

class PaymentPage extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();

  String total;
  int tot;

  PaymentPage({this.total,this.tot});


  void _onPressed() async {
    String token = randomAlphaNumeric(15)+randomNumeric(5);
    int n =1;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String user = _firebaseServices.getUserId();
    _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        int sum=0;
        sum += 20*(n);
        _firebaseServices.usersRef
            .doc(_firebaseServices.getUserId())
            .collection("Points")
            .doc("5uTUFouBUEVkq3fVrM2O")
            .set({"points": sum
        });

        _firebaseServices.usersRef
            .doc(_firebaseServices.getUserId())
            .collection("Orders")
            .doc(token+"$n")
            .set({
          "OrderID": token+"$n",
          "price":result.data()['price'],
          "productId":result.data()['productId'],
          "date": DateTime.now(),
        });
        n++;



        //what to write here so that new documents would be created in other collection
        return _firebaseServices.usersRef
            .doc(_firebaseServices.getUserId())
            .collection("Cart")
            .doc(result.data()['productId'])
            .delete();
      });
    });
  }

  String _address = "";

  final SnackBar _snackBar = SnackBar(
    content: Text(
      "Address saved",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFDCDCDC),

      ///navbar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        height: 80.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Expanded(
            child: GestureDetector(
              onTap: () async {
                await _onPressed();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ConfirmPage()));
              },
              child: Container(
                height: 70.0,
                width: 150.0,
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Color(0XFF2a2a4a),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Confirm Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 70.0,
              bottom: 30.0,
            ),
            decoration: BoxDecoration(
                color: Color(0XFF2a2a4a),
                borderRadius: BorderRadius.circular(15.0)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      "Total Cart Value\n",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " $total/-",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " value after discount ",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),

                    ),
                    Text(
                      "$tot",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
