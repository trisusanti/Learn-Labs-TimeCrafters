import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tubes1/services/auth.dart';
import 'package:tubes1/ui/widgets/forgot_password.dart';
import 'package:tubes1/ui/widgets/home_page.dart';
import 'package:tubes1/ui/widgets/signup.dart';
import 'package:tubes1/ui/widgets/theme.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "", password = "";
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isPasswordVisible = false;
  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/sign.png', height: 250),
              SizedBox(height: 5),
              Text(
                'Welcome Back!',
                style: headingStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 33,
                    color: Colors.black),
              ),
              Text(
                'Please enter your credentials to continue.',
                style: headingStyle.copyWith(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 32),
              Form(
                key: _formkey,
                child: Column(
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
                      decoration:
                          buildInputDecoration('Email', IconlyBroken.message),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      focusNode: passwordFocusNode,
                      obscureText: !isPasswordVisible,
                      decoration: buildInputDecorationWithVisibilityToggle(
                        'Password',
                        IconlyBroken.lock,
                        isPasswordVisible,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: subTitleStyle.copyWith(
                        color: darkGreyClr, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email = mailcontroller.text;
                      password = passwordcontroller.text;
                    });
                  }
                  userLogin();
                },
                splashColor: Colors.amberAccent,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: headingStyle.copyWith(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "OR",
                  style:
                      subTitleStyle.copyWith(color: darkGreyClr, fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  AuthMethods().signInWithGoogle(context);
                },
                splashColor: primaryClr,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: darkGreyClr),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/google-logo.png", width: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign-In with Google",
                          style: headingStyle.copyWith(
                              color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don\'t have an account? ",
                    style: headingStyle.copyWith(
                        fontSize: 16, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      " Sign Up",
                      style:
                          headingStyle.copyWith(fontSize: 16, color: purpleClr),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
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
      prefixIcon: Icon(iconData),
      suffixIcon: IconButton(
        icon: isVisible ? Icon(IconlyBroken.hide) : Icon(IconlyBroken.show),
        onPressed: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
      ),
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
