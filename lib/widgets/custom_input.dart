import 'package:e_bookstore/screens/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputButton extends StatelessWidget{
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  InputButton({this.hintText,this.onChanged,this.onSubmitted,this.focusNode,this.textInputAction,this.isPasswordField});
  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 25.0,
      ),
      decoration: BoxDecoration(
          color: Color(0XFFDCDCDC).withOpacity(0.8),
          borderRadius: BorderRadius.circular(25.0)
      ),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration:InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "hint text",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          )
        ),
        style: Constants.RText,
      ),
    );
  }
}