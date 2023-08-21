import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [
    {"note": "Finish the first course"},
    {"note": "Start the second course"},
    {"image": "flutter_image_1.png"},
    {"image": "firebase_image_1.png"},
  ];

  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed("signin");
            },
            icon: Icon(Icons.exit_to_app_outlined)),
        title: Text(
          "Home Page",
          style: GoogleFonts.ibmPlexSansArabic(
              textStyle: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.note_add_outlined,
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
      ),
      body: SafeArea(
          child: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
                key: Key("$index"),
                child: ListNotes(
                  notes: notes[index],
                ));
          },
          itemCount: notes.length,
        ),
      )),
    );
  }
}

class ListNotes extends StatelessWidget {
  final notes; // constructor
  ListNotes({this.notes});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Image.asset(
              "images/Note_image1 Background Removed.png",
              fit: BoxFit.fill,
            )),
        Expanded(
          flex: 4,
          child: ListTile(
            title: Text("Title"),
            subtitle: Text(
              "${notes['note']}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
          ),
        ),
      ],
    ));
  }
}
