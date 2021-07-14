import 'package:flutter/material.dart';



// ignore: non_constant_identifier_names
Container BoxCard(int a, String b, double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
          ),
        ],
        borderRadius: new BorderRadius.all(
            Radius.circular(10.0))),
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
        SizedBox(
          width: 5.0,
        ),
        Text(
          b,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'Architects',
              fontWeight: FontWeight.w600),
        )
      ],
    ),


  );
}
// ignore: non_constant_identifier_names
Text WardsFont(String name) {
  return Text(name,textAlign: TextAlign.center,style: TextStyle(
    fontFamily: 'Architects',
    color: Colors.black,
    fontSize: 27.0,
    fontWeight: FontWeight.w700,
  ),);
}

// ignore: non_constant_identifier_names
Container ImgList(String index) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
            image: NetworkImage(index),
            fit: BoxFit.cover)),

  );
}
