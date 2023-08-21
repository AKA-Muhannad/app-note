import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var username, email, password;

  GlobalKey<FormState> formState = new GlobalKey();

  Signup() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // 👇 returns credential if the sign up success
        return credential;
      } on FirebaseAuthException catch (e) {
        // check the weakness of the password
        if (e.code == 'weak-password') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The password provided is too weak 😥"))
            ..show();
          print('The password provided is too weak.');

          // check the email is exist or not
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The account already exists for that email 🫢", style: TextStyle(fontSize: 15),))
            ..show();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      print("Valid 👌");
    } else {
      print("Not Valid 👉👌");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Image.asset(
            "images/pinterest_board_photo Background Removed.png",
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (newValue) {
                        username = newValue;
                      },
                      validator: (value) {
                        if (value!.length > 20) {
                          return "username cannot be more than 20 charaters";
                        }
                        if (value.length < 2) {
                          return "username cannot be less than 2 charaters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                    SizedBox(height: 1.5,),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          "If you have account ",
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed("signin");
                          },
                          child: Text(
                            " 👉 Log in",
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
                    SizedBox(height: 10,),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // disabledBackgroundColor: Colors.blueGrey,
                            // backgroundColor: Colors.blue
                            ),
                        onPressed: () async {
                          var response = await Signup();
                          print("-------------");
                          // 👇 condtion below means the sign up is success
                          if(response != null){
                            Navigator.of(context).pushReplacementNamed("home");
                          }else{
                            print("Failed !!");
                          }
                          print(response);
                        },
                        child: Text(
                          "Create account",
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: TextStyle(
                                fontSize: 18,
                                wordSpacing: 2,
                                letterSpacing: 1),
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
