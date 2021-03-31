import 'package:e_bookstore/screens/constants.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String imagep;
  final String text;
  final String imageq;

  ProfileListItem({this.imagep, this.text,this.imageq});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      margin: EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 15.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 18.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Color(0XFF2a2a4a),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(
            image: AssetImage(
              imagep,
            ),
            width: 28.0,
            color: Color(0XFFDCDCDC),

          ),
          //SizedBox(width: 25.0),
          Text(
            this.text,
            style:TextStyle(color: Color(0XFFDCDCDC),fontSize: 12.0,fontWeight: FontWeight.w800),
          ),
          Image(
            image: AssetImage(
              imageq,
            ),
            width: 20.0,
            color: Color(0XFFDCDCDC),
          ),
        ],
      ),
    );
  }
}
