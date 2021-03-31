

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/sample_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:e_bookstore/widgets/image_swipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  final String price;


  ProductPage({this.productId, this.price});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  ///Function for adding items to cart
  Future _addToCart() async {
    await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"productId":widget.productId,"price":widget.price});
  }

  ///Function for adding items to saved
  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({});
  }


  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to the cart",),
  );

  final SnackBar _snackBar1 = SnackBar(
    content: Text("Product added to the saved",),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder(
              future: _firebaseServices.productsRef.doc(widget.productId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> documentData = snapshot.data.data();
                  //list of images
                  List imageList = documentData['images'];
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 90.0,
                    ),
                    children: [
                      ImageSwipe(
                        imageList: imageList,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
                        child: Text(
                          "${documentData['name']}",
                          style: Constants.RText,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 22.0),
                            child: Text(
                              "\₹ ${documentData['price']}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(width:90.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 22.0),
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                height:40.0,
                                width:100.0,
                                decoration:BoxDecoration(borderRadius: BorderRadius.circular(20.0),color:Color(0XFF2a2a4a),),
                                child: Text(
                                  "View Samples",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SamplePage(productId: widget.productId),
                                ));
                              },
                            ),
                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 22.0),
                        child: Text(
                          "${documentData['total']} pages",
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 22.0),
                        child: Text(
                          "${documentData['description']}",
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.transparent,
                        ),
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _addToSaved();
                                  Scaffold.of(context).showSnackBar(_snackBar1);
                                },
                                child: Container(
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(
                                      "assets/images/saved.png",
                                    ),
                                    height: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await _addToCart();
                                    Scaffold.of(context).showSnackBar(_snackBar);
                                  },
                                  child: Container(
                                    height: 55.0,
                                    margin: EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0XFF2a2a4a),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Add To Cart",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            CustomActionBar(
              hasBackArrow: true,
              hasTitle: false,
              hasBackground: true,
            )
          ],
        ),
      ),
    );
  }
}
