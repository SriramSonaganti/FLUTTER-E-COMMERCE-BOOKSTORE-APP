import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bookstore/screens/Home_page.dart';
import 'package:e_bookstore/screens/Login_page.dart';
import 'package:e_bookstore/screens/about_us.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/orders_page.dart';
import 'package:e_bookstore/screens/view_details.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/Profile_List.dart';
import 'package:e_bookstore/widgets/custom_action_bar.dart';
import 'package:e_bookstore/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProfileTab extends StatelessWidget {

  FirebaseServices _firebaseServices = FirebaseServices();
  String Name = "";


  String getname(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Expanded(child:ListView(
           children: <Widget> [
             SizedBox(height: 40.0,),
             Text(
               "Profile",
               style: Constants.RHead,
               textAlign: TextAlign.center,
             ),
             SizedBox(height: 20.0,),
             Container(
                 decoration: BoxDecoration(
                   color: Color(0XFFDCDCDC),
                   shape: BoxShape.circle,
                 ),
                 height:120.0,
                 width: 120.0,
                 margin: EdgeInsets.all(5.0),
                 child:Center(
                   child:  Image(image: AssetImage("assets/images/user.png"
                   ),
                       height: 75.0,
                       width: 75.0,
                       color: Color(0XFF2a2a4a)
                   ),
                 )
             ),
             SizedBox(height: 30.0,),


             FlatButton(
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => ViewDetails()
                 ));
               },
               child: ProfileListItem(
                 imagep: "assets/images/user.png",
                 text: "My Details",
                 imageq:"assets/images/next.png",
               ),
             ),
             FlatButton(
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => MyOrders()
                 ));
               },
               child: ProfileListItem(
                 imagep: "assets/images/order.png",
                 text: "My Orders",
                 imageq:"assets/images/next.png",
               ),
             ),
             FlatButton(
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => AboutPage()
                 ));
               },
               child: ProfileListItem(
                 imagep: "assets/images/help.png",
                 text: "About Us",
                 imageq:"assets/images/next.png",
               ),
             ),
             FlatButton(
               onPressed:(){
                 FirebaseAuth.instance.signOut();
               },
               child: ProfileListItem(
                 imagep: "assets/images/logout.png",
                 text: "Logout",
                 imageq:"assets/images/next.png",
               ),
             ),
           ],
         ))
        ],
      ),
    );
  }
}