import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/cart_page.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  final bool hasCartIcon;

  CustomActionBar({this.title, this.hasBackArrow,this.hasTitle,this.hasBackground,this.hasCartIcon});

  final CollectionReference _usersRef = FirebaseFirestore.instance.collection("Users");
  User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    bool _hasCartIcon = hasCartIcon ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).accentColor,
          ],
          begin: Alignment(0.5,0),
          end: Alignment(0,0.5),
        ):null
      ),
      padding: EdgeInsets.only(
        top: 35.0,
        left: 24.0,
        right: 24.0,
        bottom: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap:(){ Navigator.pop(context);},
              child: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(""
                      "assets/images/back_arrow.png"
                  ),
                  color: Color(0XFFDCDCDc),
                  width: 16.0,
                  height: 25.0
                ),
              ),
            ),
          if(_hasTitle)
            Text(
              title ??  "",
              style: TextStyle(color: Color(0XFFDCDCDC), fontSize: 20.0,fontWeight: FontWeight.w800),
            ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Stack(
              overflow: Overflow.visible,
              children: [
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: Image(image: AssetImage("assets/images/order.png"),
                      color: Color(0XFFDCDCDC),
                      height: 35.0,
                      width: 35.0,),
                  ),
                  Positioned(
                    top: -3,
                    right: 0,
                    child: Container(
                      height: 18.0,
                      width: 18.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.5, color: Colors.transparent),
                      ),
                      child: Center(
                          child: StreamBuilder(
                            stream: _usersRef.doc(_user.uid)
                                .collection("Cart")
                                .snapshots(),
                            builder: (context, snapshot) {
                              int _totalItems = 0;

                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                List _documents = snapshot.data.docs;
                                _totalItems = _documents.length;
                              }
                              return Text(
                                "$_totalItems" ?? null,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              );
                            },
                          )

                      ),
                    ),
                  ),

              ],
            )
          )
        ],
      ),
    );
  }
}
