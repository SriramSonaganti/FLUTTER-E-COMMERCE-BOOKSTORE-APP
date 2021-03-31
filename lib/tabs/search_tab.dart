import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_input.dart';
import 'package:e_bookstore/widgets/product_cart.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            if (_searchString.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 180.0,
                          child: Image(
                            image: AssetImage("assets/images/search.png"),
                            color: Color(0XFF2a2a4a).withOpacity(0.9),
                            height: 80.0,
                            width: 200.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),
              )
            else
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productsRef
                    .orderBy('search_string')
                    .startAt([_searchString]).endAt(
                        ["$_searchString\uf8ff"]).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.data.docs.isNotEmpty) {
                    // Display the data inside a list view
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 128.0,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 60.0, bottom: 20.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 100.0,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/no_search.png"),
                                  color: Color(0XFF2a2a4a).withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "no results found!",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: 45.0,
              ),
              child: InputButton(
                hintText: "Search here",
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
