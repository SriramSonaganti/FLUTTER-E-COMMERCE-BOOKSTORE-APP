import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:e_bookstore/widgets/product_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();


  Future<bool> _onWillPop() async {
    return (await showDialog(
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    _onWillPop();
    return Scaffold(
      backgroundColor: Color(0XFF2a2a4a),
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef.get(),
              builder: (context, snapshot) {
                /// to display products
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 120.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return ProductCart(
                        title: document.data()['name'],
                        author: document.data()['author'],
                        imageUrl: document.data()['images'][0],
                        price: "\₹ ${document.data()['price']}",
                        cost: "${document.data()['price']}",
                        productId: document.id,
                      );
                    }).toList(),
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
              title: "Home",
              hasBackArrow: false,
            ),

          ],
        ),
      ),
    );
  }
}
