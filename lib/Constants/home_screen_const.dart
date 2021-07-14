import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Text HospitalCard(String type,String about) {
  return Text(
    about + type,
    style: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'ZillaSlab',
    ),
  );
}

Divider buildDivider() {
  return const Divider(
    color: Colors.black,
    height: 20,
    thickness: 2.0,
    indent: 20,
    endIndent: 0,
  );
}

// ignore: non_constant_identifier_names
Container BoxCard( int a,String b, double width, double height) {
  return Container(

    width: width,
    height: height,
    child: Column(
      children: [
        Text(
          '$a',
          style: TextStyle(
              color: Colors.black,
              fontSize: 75.0,
              fontFamily: 'ZillaSlab',
              fontWeight: FontWeight.w700),
        ),
        Text(
          b,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'ZillaSlab',
              fontWeight: FontWeight.w600),
        )
      ],
    ),
    margin: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
      BoxShadow(
      color: Colors.grey,
      blurRadius: 10.0,
    ),]
    ),
  );
}