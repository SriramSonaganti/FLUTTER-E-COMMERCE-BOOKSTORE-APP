import 'package:e_bookstore/screens/Register_page.dart';
import 'package:e_bookstore/screens/constants.dart';
import 'package:e_bookstore/screens/size_config.dart';
import 'file:///E:/dev/e_bookstore/lib/screens/size_config.dart';
import 'package:e_bookstore/widgets/custom_button.dart';
import 'package:e_bookstore/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///E:/dev/e_bookstore/lib/screens/size_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  //Build an alert dialog to display ome errors
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

  Future<String> __loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  void _SubmitForm() async {
    //setting the form to loading state
    setState(() {
      _loginLoading = true;
    });

    //Run the method for login
    String _signInFeedback = await __loginAccount();
    if (_signInFeedback != null) {
      _alertDialog(_signInFeedback);

      setState(() {
        _loginLoading = false;
      });
    }
  }

  //First default loading state is false
  bool _loginLoading = false;

  //form input field variables

  String _loginEmail = "";
  String _loginPassword = "";

  //focus node for input fields
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
                      image:AssetImage(
                        "assets/images/divine.png",
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    InputButton(
                      hintText: "E-mail",
                      onChanged: (value) {
                        _loginEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    InputButton(
                      hintText: "Password",
                      onChanged: (value) {
                        _loginPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _SubmitForm();
                      },
                    ),
                    cButton(
                      text: "Login",
                      onPressed: () {
                        //to open dialogbox
                        _SubmitForm();
                      },
                      loading: _loginLoading,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    top: 120.0,
                  ),
                  child: cButton(
                    text: "Sign Up",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    outlineButton: true,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
