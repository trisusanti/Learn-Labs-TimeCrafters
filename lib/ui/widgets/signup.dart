import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tubes1/services/auth.dart';
import 'package:tubes1/ui/widgets/home_page.dart';
import 'package:tubes1/ui/widgets/signin.dart';
import 'package:tubes1/ui/widgets/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isPasswordVisible = false;
  final _formkey = GlobalKey<FormState>();

  void showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the pop-up
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  registration() async {
    if (password != null &&
        namecontroller.text != "" &&
        mailcontroller.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 20.0),
        )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
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
              Image.asset('images/sign.png', height: 190),
              SizedBox(height: 16),
              Text(
                'Get On Board !',
                style: headingStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 33,
                    color: Colors.black),
              ),
              Text(
                'Transform your to-do lists into achievements',
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
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      controller: namecontroller,
                      focusNode: nameFocusNode,
                      decoration:
                          buildInputDecoration('Name', IconlyBroken.profile),
                    ),
                    SizedBox(height: 16),
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email = mailcontroller.text;
                      name = namecontroller.text;
                      password = passwordcontroller.text;
                    });
                  }
                  registration();
                },
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
                      "Sign Up",
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
                      subTitleStyle.copyWith(color: Colors.black, fontSize: 12),
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
                    "Already have an account? ",
                    style: headingStyle.copyWith(
                        fontSize: 16, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text(
                      " Log In",
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
