import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => SigninState();
}

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
            height: 50,
              child: Center(
            child: CircularProgressIndicator(),
          )),
        );
      });
}

class SigninState extends State<Signin> {
  var email, password;
  GlobalKey<FormState> formState = new GlobalKey();
  Signin() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        // 👇 returns credtion if the log in was success
        return credential;
      } on FirebaseAuthException catch (e) {
        // check if the user exist or not
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              context: context,
              title: "Error",
              body: Text(
                "No user found for that email 🫢",
                style: TextStyle(fontSize: 15),
              ))
            ..show();
          print('No user found for that email.');
          // check if the password is correct or not
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              dialogType: DialogType.error,
              animType: AnimType.bottomSlide,
              context: context,
              title: "Error",
              body: Text(
                "Wrong password provided for that user 😥",
                style: TextStyle(fontSize: 15),
              ))
            ..show();
          print('Wrong password provided for that user.');
        }
      }
      print("Valid 👌");
    } else {
      print("Not Valid 💀");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Image.asset("images/pinterest_board_photo Background Removed.png"),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (newValue) {
                        email = newValue;
                      },
                      validator: (value) {
                        if (value!.length > 40) {
                          return "Email cannot be more than 40 charaters";
                        }
                        if (value.length < 2) {
                          return "Email cannot be less than 6 charaters";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        password = newValue;
                      },
                      validator: (value) {
                        if (value!.length > 20) {
                          return "password cannot be more than 20 charaters";
                        }
                        if (value.length < 8) {
                          return "password cannot be less than 8 charaters";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          )),
                    ),
                    SizedBox(
                      height: 1.5,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "If you don't have account ",
                              style: GoogleFonts.ibmPlexSansArabic(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("signup");
                              },
                              child: Text(
                                "👉 Register",
                                style: GoogleFonts.ibmPlexSansArabic(
                                  textStyle: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // disabledBackgroundColor: Colors.blueGrey,
                            // backgroundColor: Colors.blue
                            ),
                        onPressed: () async {
                          var response =
                              await Signin(); // it will return the usercredntial value
                          // 👇 condtion below means the sign in is success
                          if (response != null) {
                            Navigator.of(context).pushReplacementNamed("home");
                          }
                          print(response);
                        },
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: TextStyle(
                                fontSize: 18, wordSpacing: 2, letterSpacing: 1),
                          ),
                          // ***** 👇 below is a code that it can be done *****
                          // style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      )),
    );
  }
}
