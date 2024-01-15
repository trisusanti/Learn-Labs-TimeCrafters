import 'package:iconly/iconly.dart';
import 'package:tubes1/ui/widgets/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tubes1/ui/widgets/theme.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = new TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 20.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 20.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 70.0,
            ),
            Image.asset("images/lock.png", width: 200),
            Container(
              alignment: Alignment.topCenter,
              child: Text("Password Recovery",
                  style: headingStyle.copyWith(color: Colors.black)),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Enter your mail",
              style: headingStyle.copyWith(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ListView(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter E-mail';
                              }
                              return null;
                            },
                            controller: mailcontroller,
                            focusNode: emailFocusNode,
                            decoration: buildInputDecoration(
                                'Email', IconlyBroken.message),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = mailcontroller.text;
                                });
                                resetPassword();
                              }
                            },
                            splashColor: Colors.amberAccent,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Send Email",
                                  style: headingStyle.copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: headingStyle.copyWith(
                                    fontSize: 16, color: Colors.black),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Create",
                                  style: headingStyle.copyWith(
                                      fontSize: 16, color: purpleClr),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String labelText, IconData iconData) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(iconData),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: purpleClr),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyClr),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  InputDecoration buildInputDecorationWithVisibilityToggle(
      String labelText, IconData iconData, bool isVisible) {
    return InputDecoration(
      labelText: labelText,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: purpleClr),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyClr),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
