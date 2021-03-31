import 'package:e_bookstore/screens/details_page.dart';
import 'package:e_bookstore/services/firebase_services.dart';
import 'package:e_bookstore/widgets/custom_button.dart';
import 'package:e_bookstore/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ///To display some errors as pop up
  Future<void> _alertDialog(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(("Error")),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  ///To Create New Account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  ///To submit the values in the box to output
  void _SubmitForm() async {
    setState(() {
      _registrationLoading = true;
    });

    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialog(_createAccountFeedback);

      setState(() {
        _registrationLoading = false;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => DetailsPage()));
    }
  }

  //create default loading state
  bool _registrationLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  //focus node for input feilds
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2a2a4a),
      body: ListView(
        padding: EdgeInsets.only(
          top: 90.0,
        ),
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 220.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/divine.png",
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// to take email input
                    InputButton(
                      hintText: "E-mail",
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    /// to take password input
                    InputButton(
                      hintText: "Password",
                      onChanged: (value) {
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _SubmitForm();
                      },
                    ),

                    cButton(
                      text: "Sign Up",
                      onPressed: () {
                        //to open dialogbox
                        _SubmitForm();
                      },
                      loading: _registrationLoading,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    top: 120.0,
                  ),
                  child: cButton(
                    text: "Back to  login",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    outlineButton: true,
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
