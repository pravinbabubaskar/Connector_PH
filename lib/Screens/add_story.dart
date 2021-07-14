import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddStory extends StatefulWidget {
  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  @override
  Widget build(BuildContext context) {
    final _store = FirebaseFirestore.instance;
    String name,title,data,time;
    bool spinner = false;
    return Scaffold(
      backgroundColor: Hexcolor('#eff48e'),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Add Storie 📚',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Architects',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Hexcolor('#d2e603'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              TextField(
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0,height: 2.0),
                onChanged: (value) {
                    name = value;
                    },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Name',
                  labelStyle:
                  TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 25.0),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0,height: 2.0),
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Title',
                  labelStyle:
                  TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 25.0),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0,height: 2.0),
                onChanged: (value) {
                  //Do something with the user input.
                  data = value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Story',

                  labelStyle:
                  TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 25.0),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                )

              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0,height: 2.0),
                onChanged: (value) {
                  time = value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Read Time',
                  labelStyle:
                  TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 25.0),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Hexcolor('#d2e603'),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        spinner = true;
                      });
                      try {
                        print(name);
                        _store.collection('Stories').add({
                          'Name':name,
                          'Title':title,
                          'Data':data,
                          'Time':time,
                          'Flag':0,
                        });
                        Navigator.pushNamed(context, 'stories');
                        setState(() {
                          spinner = false;

                        });
                      } catch (e) {
                        var error=e.message;
                        if(error==null)
                          error="Some fields are empty fill it";
                        setState(() {
                          spinner = false;
                        });
                      }
                    },
                    minWidth: 200.0,
                    height: 50.0,
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontFamily: 'Architects',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25.0
                      ),
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }


}
