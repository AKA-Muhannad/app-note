import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Add Notes",
          style: GoogleFonts.ibmPlexSansArabic(textStyle: TextStyle(color: Colors.white)), 
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Container(
          child: Column(children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  maxLength: 30,
                  minLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Title Note",
                      prefixIcon: Icon(Icons.note_outlined)),
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 200,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Note",
                      prefixIcon: Icon(Icons.note_outlined)),
                ),
                ElevatedButton.icon(
                    icon: Icon(Icons.image_outlined),
                    onPressed: () {
                      showButtonSheet();
                    },
                    label: Text(
                      "Add Image",
                    )),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showButtonSheet();
                  },
                  label: Text(
                    "Add Note",
                  ),
                ),
              ],
            ))
          ]),
        ),
      )),
    );
  }

  showButtonSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(top: 15),
            height: 200,
            child: Column(
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_album_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "From Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "From Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
