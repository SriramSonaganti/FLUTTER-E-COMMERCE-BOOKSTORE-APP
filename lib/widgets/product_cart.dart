
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/product_page.dart';
import 'file:///E:/dev/e_bookstore/lib/screens/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  final String author;
  final String cost;
  ProductCart({this.onPressed, this.title, this.price, this.productId,this.imageUrl,this.author,this.cost});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(productId: productId,price: cost,),
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 197.0,
            width: 340.0,
            decoration: BoxDecoration(
              color: Color(0XFFDCDCDC).withOpacity(0.4),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            ///Image
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.centerLeft,
                  height: 170.0,
                  width: 150.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      "$imageUrl" ?? "null",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height:180.0,
                  width: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title ?? "null",
                        textAlign: TextAlign.left,
                        style: Constants.RText,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      Text(
                        author ?? "null",
                        textAlign: TextAlign.center,
                        style: Constants.regular,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        softWrap: true,
                      ),
                      Container(
                        height:40.0,
                        width:100,
                        decoration: BoxDecoration(
                            color: Color(0XFF2a2a4a),
                          borderRadius: BorderRadius.circular(12.0)
                        ),
                        child:Center(
                          child: Text(
                            price ?? "null",
                            style:TextStyle(color: Colors.white),
                            overflow: TextOverflow.visible,
                            maxLines: 1,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}