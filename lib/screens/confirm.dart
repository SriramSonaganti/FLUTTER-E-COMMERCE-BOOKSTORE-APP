import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/orders_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatelessWidget {


  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2a2a4a),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 300.0),
                child: Text("Your Order is confirmed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800
                    ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyOrders()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    child: Text("Go To My Orders", style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),),
                    width: 250.0,
                    height: 61.0,
                    decoration: BoxDecoration(
                      color: Color(0XFFDCDCDC),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
