import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'package:e_bookstore/screens/tracking_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/Bottom_tabs.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:e_bookstore/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class MyOrders extends StatelessWidget {
  final String ProductId;
  final String Pref;

  MyOrders({this.ProductId,this.Pref});


  FirebaseServices _firebaseServices = FirebaseServices();
  String s="";
  void getDate(){
    _firebaseServices.usersRef.doc(_firebaseServices.getUserId()).collection("Orders").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        s= _firebaseServices.usersRef.doc(_firebaseServices.getUserId()).collection("Orders").doc(result.data()['productId']).get().toString();
        return s;
      });
    });
  }
  String formatTimestamp(Timestamp timestamp) {
    var format = new DateFormat('y-MM-d'); // 'hh:mm' for hour & min
    return format.format(timestamp.toDate());

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Fetching items in cart
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Orders")
                  .get(),
              builder: (context, snapshot) {
                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done && snapshot.data.docs.isNotEmpty) {
                  // Display the data inside a list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 108.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(
                                      productId: document.data()['productId'],
                                    ),
                              ));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef
                              .doc(document.data()['productId'])
                              .get(),
                          builder: (context, productSnap) {
                            if (productSnap.connectionState == ConnectionState.done ) {
                              Map _productMap = productSnap.data.data();
                              String time = formatTimestamp(
                                  document.data()['date']);
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 75.0,
                                    height: 100.0,
                                    child: AspectRatio(
                                      aspectRatio: 0.88,
                                      child: Container(
                                        padding: EdgeInsets.only(top:10.0,left: 10.0,bottom: 10.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F6F9),
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                        child: Image.network(
                                          "${_productMap['images'][0]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 200.0,
                                    height: 65.0,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_productMap['name']}",
                                          overflow: TextOverflow.visible,
                                          maxLines: 1,
                                          softWrap: true,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          "\₹ ${_productMap['price']}",
                                          style: Constants.RText,
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          "Ordered on $time",
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(fontSize: 10.0),
                                          maxLines: 1,

                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20.0,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TrackingPage(
                                                  productId: document.id,
                                                  Pref: document.data()['productId'],
                                                ),
                                          ));
                                    },
                                      child: Image(image: AssetImage("assets/images/tracking.png"),height: 40.0,))

                                ],
                              );
                            }
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator()
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: Text("You dont have any orders yet")
                  ),
                );
              },
            ),

            CustomActionBar(
              hasBackArrow: true,
              title: "Orders",
            ),
            TabButton(),
          ],
        ),
      ),
    );
  }
}