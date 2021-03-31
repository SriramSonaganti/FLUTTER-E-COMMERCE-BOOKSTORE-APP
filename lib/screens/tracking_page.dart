import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/orders_page.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/tabs/Profile_tab.dart';
import 'package:e_bookstore/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  final String productId;
  final String Pref;


  TrackingPage({this.productId, this.Pref});

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  ///Function to cancel the order
  void _CancelOrder() {
    _firebaseServices.usersRef
        .doc(_firebaseServices
        .getUserId())
        .collection("Orders")
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2a2a4a),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FutureBuilder(
                future: _firebaseServices.productsRef.doc(widget.Pref).get(),
                builder: (context, productSnap) {
                  if (productSnap.connectionState == ConnectionState.done) {
                    Map _productMap = productSnap.data.data();
                    return Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 100.0),
                          height: 200.0,
                          width: 150.0,
                          color: Colors.deepOrange,
                          child: Image.network(
                            "${_productMap['images'][0]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _CancelOrder();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyOrders()
                              ));
                            });

                          },
                          child: Container(
                            height: 45.0,
                            width: 97.0,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 50.0, top: 100.0),
                            child: Text(
                              "Cancel Order",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red),
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0),color: Colors.white,),
                          ),
                        ),
                      ],
                    );
                  }

                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Order Tracking",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0XFFDCDCDC)),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.only(left: 10.0),
                height: 56.0,
                width: 317.0,
                decoration: BoxDecoration(
                    color: Color(0XFFDCDCDC),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text("Tracking Id: ${widget.productId}",style: TextStyle(fontWeight:FontWeight.w800,fontSize: 12.0)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 35.0),
                  padding: EdgeInsets.only(top: 20.0, bottom: 45.0),
                  height: 200.0,
                  width: 317.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "   Your Order is managed \n by FED EX courier Services",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0XFFDCDCDC)),
                      ),
                      Text(
                        "Track your Order in FED EX  \n   by provided Tracking ID",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0XFFDCDCDC)),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
