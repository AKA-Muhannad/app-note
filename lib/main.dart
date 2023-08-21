import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_notes/auth/Signin.dart';
import 'package:app_notes/auth/SignUp.dart';
import 'package:app_notes/crud/AddNotes.dart';
import 'package:app_notes/home/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

bool isSignin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var user = FirebaseAuth.instance.currentUser;
  // 👇 means not sign in yet
  if (user == null) {
    isSignin = false;
  } else {
    isSignin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 121, 107, 50),
        secondaryHeaderColor: Color.fromRGBO(255, 193, 7, 75),
        textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(textTheme).copyWith(
            bodyMedium:
                GoogleFonts.ibmPlexSansArabic(textStyle: textTheme.bodyMedium)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // style: TextButton.styleFrom(
          //     backgroundColor: Color.fromRGBO(255, 193, 7, 75),
          //     textStyle: TextStyle(
          //       color: Colors.black87,
          //       fontSize: 20,
          //       wordSpacing: 2,
          //       letterSpacing: 1,
          //     ))
          style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(255, 193, 7, 75),
              textStyle: GoogleFonts.ibmPlexSansArabic(
                fontSize: 18,
                wordSpacing: 2,
                letterSpacing: 1,
              )),
        ),
      ),
      home: isSignin == false ? Signin() : HomePage(),
      routes: {
        "signin": (context) => Signin(),
        "signup": (context) => Signup(),
        "home": (context) => HomePage(),
        "add": (context) => AddNotes(),
      },
    );
  }
}
