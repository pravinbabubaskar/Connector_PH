import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'add_story.dart';
import 'story.dart';
class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  final _store = FirebaseFirestore.instance;
  bool spinner= false;
  int flag = 1;
  List<Map> Stories = List();
  @override
  void initState() {
    super.initState();
    setState(() {
      spinner=true;
    });
    getdata();
  }
  @override
  void getdata() async{
    final snapshots = await _store.collection("Stories").where('Flag', isEqualTo:flag).get();
    for (var m in snapshots.docs) {
      var t = m.data();
      Stories.insert(0, t);
    }
    setState(() {
      spinner=false;
    });

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#eff48e'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'bot');
        },
        child: Icon(Icons.chat, color: Colors.black),
        backgroundColor: Hexcolor('#d2e603'),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'COVID Stories',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Architects',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddStory()));
              }),
        ],
        backgroundColor: Hexcolor('#d2e603'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: ListView.builder(
            itemCount: Stories.length,
            itemBuilder: (BuildContext context, int index) {
              return _Dummy(index);
            }),
      ),
    );
  }
  Widget _Dummy(int index){
    Map t = Stories[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Story(t)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              color: Hexcolor('#2ec1ac'),

            ),
            Container(
                margin: EdgeInsets.all(16.0),
                color: Colors.white,
                child: ListTile(
                  title: Text(t['Title'],style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'ZillaSlab'
                  )) ,
                  subtitle: Text.rich((TextSpan(
                      children: [
                        WidgetSpan(child: SizedBox(height: 40.0)),
                        TextSpan(text: t['Name'],style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'ZillaSlab'
                        )),
                        WidgetSpan(child: SizedBox(width: 30.0)),
                        TextSpan(text: t['Time']+' min read',style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'ZillaSlab'
                        )),
                      ]
                  )),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
