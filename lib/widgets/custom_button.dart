import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class cButton extends StatelessWidget{

  final String text;
  final Function onPressed;
  final bool outlineButton;
  final bool loading;
  cButton({this.text,this.onPressed,this.outlineButton,this.loading});
  @override
  Widget build(BuildContext context) {
    bool _outlineButton = outlineButton ?? false;
    bool _loading = loading ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 261.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineButton  ?  Colors.black :  Colors.deepOrange,
          border: Border.all(
            color:  Colors.transparent,
            width: 2.0,
          ),
            borderRadius: BorderRadius.circular(25.0)
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _loading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                      fontSize:14.0,
                      color: _outlineButton ? Colors.white : Colors.white,
                      fontWeight:FontWeight.w700,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _loading,
              child: Center(
                child: SizedBox(
                  height:30.0,
                  width:30.0,
                  child: CircularProgressIndicator(),
          ),
              ),
            ),
          ],
        ),
    )
    );
  }
}