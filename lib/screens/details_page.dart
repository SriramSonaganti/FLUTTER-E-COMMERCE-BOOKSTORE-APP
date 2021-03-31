import 'package:e_bookstore/screens/Home_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_button.dart';
import 'package:e_bookstore/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();

  String name = "";
  String phone = "";
  String address = "";
  String zipcode = "";
  String userEmail = FirebaseAuth.instance.currentUser.email;

  DetailsPage(
      {this.userEmail, this.address, this.phone, this.name, this.zipcode});

  void _getDetails() {
    _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Details")
        .doc()
        .set({
      "name": name,
      "phone": phone,
      "email": FirebaseAuth.instance.currentUser.email,
      "address": address
    });


  }

  FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF2a2a4a),
        body: Container(
          child: ListView(
            padding: EdgeInsets.only(
              top: 90.0,
            ),
            children: [
              Column(
                children: [
                  Container(
                    height: 110.0,
                    child: Text(
                      "Please Enter Your Details \n  \n",
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                  ),
                  InputButton(
                    hintText: "name",
                    onChanged: (value) {
                      name = value;
                    },
                    onSubmitted: (value) {
                      _focusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  InputButton(
                    hintText: "phone",
                    onChanged: (value) {
                      phone = value;
                    },
                    onSubmitted: (value) {
                      _focusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  InputButton(
                    hintText: "Address ",
                    onChanged: (value) {
                      address = value;
                    },
                    onSubmitted: (value) {
                      _focusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  InputButton(
                    hintText: "zipcode",
                    onChanged: (value) {
                      zipcode = value;
                    },
                    onSubmitted: (value) {
                      _focusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  cButton(
                    text: "Get Started",
                    onPressed: () {
                      _getDetails();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HomePage()));
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
