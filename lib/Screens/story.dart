import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class Story extends StatelessWidget {
  Map story;
  Story(Map a){
    story=a;
  }
  @override
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
                Text(story['Title'],style: TextStyle(
                  fontSize: 35.0,
                  fontFamily: 'ZillaSlab',
                  fontWeight: FontWeight.w700
                ),),
              SizedBox(
                height: 40.0,
              ),
              Text("   "+story['Data'],style: TextStyle(
                  fontSize: 27.0,
                  fontFamily: 'ZillaSlab',

              ),)
              ],
          ),
        ),
      ),
    );
  }
}
