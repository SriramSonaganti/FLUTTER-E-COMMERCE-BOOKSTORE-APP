

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Details")
                  .get(),
              builder: (context, snapshot) {
                return Scaffold(
                  backgroundColor: Color(0xFF2A2A4A),
                  body: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 3, color: Color(0XFFDCDCDC)),
                            ),
                            height: 150.0,
                            width: 150.0,
                            margin: EdgeInsets.all(25.0),
                            child: Center(
                              child: Image(
                                  image: AssetImage("assets/images/user.png"),
                                  height: 100.0,
                                  width: 100.0,
                                  color: Color(0XFFDCDCDC)),
                            ),
                          ),

                          Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "My Details",
                              style: TextStyle(
                                  fontSize: 35.0,
                                  color: Color(0xFFDCDCDC),
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Text("Name: ${snapshot.data.docs.single.data()['name']}",style: TextStyle(fontWeight:FontWeight.w800)),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15.0),
                            height: 56.0,
                            width: 350.0,
                            decoration: BoxDecoration(
                                color: Color(0XFFf15e09).withOpacity(0.75),
                                borderRadius: BorderRadius.circular(50.0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Text("Email: ${snapshot.data.docs.single.data()['email']}",style: TextStyle(fontWeight:FontWeight.w800)),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15.0),
                            height: 56.0,
                            width: 350.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(50.0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Text("Phone: ${snapshot.data.docs.single.data()['phone']} ",style: TextStyle(fontWeight:FontWeight.w800)),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15.0),
                            height: 56.0,
                            width: 350.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(50.0)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Text("Address: \n ${snapshot.data.docs.single.data()['address']} ",style: TextStyle(fontWeight:FontWeight.w800)),
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(20.0),
                            height: 126.0,
                            width: 350.0,
                            decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
