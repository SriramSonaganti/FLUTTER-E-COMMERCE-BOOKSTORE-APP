import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Saved")
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
                      String id = document.id;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPage(
                                  productId: document.id,
                                ),
                              ));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef
                              .doc(document.id)
                              .get(),
                          builder: (context, productSnap) {
                            if (productSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text("${productSnap.error}"),
                                ),
                              );
                            }

                            if (productSnap.connectionState == ConnectionState.done) {
                              Map _productMap = productSnap.data.data();
                              return Dismissible(
                                key: Key(document.id),
                                direction: DismissDirection.endToStart,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 97,
                                      height: 133,
                                      child: AspectRatio(
                                        aspectRatio: 0.88,
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
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
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_productMap['name']}",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "\₹ ${_productMap['price']}",
                                          style: Constants.RText,
                                          maxLines: 1,
                                        ),
                                        ///remove froom cart
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              _firebaseServices.usersRef
                                                  .doc(_firebaseServices
                                                  .getUserId())
                                                  .collection("Saved")
                                                  .doc(document.id)
                                                  .delete();
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 125.0),
                                            child: Container(
                                              alignment:Alignment.topRight,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                              ),
                                              height: 27.0,
                                              width: 80.0,
                                              child: Icon(
                                                Icons.remove_circle,
                                                size: 25.0,
                                                color: Colors.red.withRed(500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                background: Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFFFE6E6),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(Icons.remove_circle)
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    _firebaseServices.usersRef
                                        .doc(_firebaseServices.getUserId())
                                        .collection("Saved")
                                        .doc(document.id)
                                        .delete();
                                  });
                                },
                              );
                            }

                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top:300.0),
                      child: Column(
                        children: [
                          Container(
                            height:100.0,
                            child:Image(
                              image:AssetImage("assets/images/ribbon1.png"),color:Color(0xFF2A2A4A)
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top:18.0),
                            child: Text("No Saved Books",style:TextStyle(fontSize:25.0)),
                          )
                        ],
                      ),
                    )
                    )
                  );
              },
            ),
            CustomActionBar(
              title: "Saved",
              hasBackArrow: false,
            ),

          ],
        ),
      ),

    );
  }
}
