import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
             Container(
              child: Column(
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    height: 390.0,
                    width: 371.0,
                    child: Column(
                      children: [
                        Container(
                          height: 48.0,
                          width: 128.0,
                          child: Center(
                            child: Text(
                              "About us",
                              style: Constants.RHead,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0XFFDCDCDC),
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        SizedBox(height: 25.0,),
                        Container(child:Text("        Bachelor Of Engineering\n Computer Science Department",style: Constants.RText,)),
                        Container(
                          child: Text(
                            "Mini Project\n B.E - V SEM",
                            style: Constants.RHead,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0)),
                          width: 300.0,
                          height: 200.0,
                          child: Image(
                            image: AssetImage(
                              "assets/images/ngit.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                      alignment: Alignment.center,
                      height: 250.0,
                      width: 320.0,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.0),color: Color(0XFFDCDCDC),),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:40.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(child: Text("V SAI PRAVALLIKA - 2453-18-733-114")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(child: Text("M KAUSHIK     -    2453-18-733-096")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(child: Text("S SRIRAM       -     2453-18-733-108")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(child: Text("K BASWANTH   -     2453- 18-733-093")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:50.0),
                              child: Container(child: Text("Project Guide - Mr. K.Srinivas",)),
                            ),

                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
