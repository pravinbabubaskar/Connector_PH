import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';
// ignore: non_constant_identifier_names
SmoothStarRating StarRating(String val) {
  return SmoothStarRating(
      allowHalfRating: true,
      starCount: 5,
      rating: double.parse(
          val),
      size: 20.0,
      isReadOnly: true,
      color: Hexcolor('#2ec1ac'),
      borderColor: Hexcolor('#3e978b'),
      spacing: 0.0);
}

void Errorbox(BuildContext context, error) {
  showDialog(
      context: context,
      builder: (context) {
        return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AlertDialog(
                  elevation: 20.0,
                  title: Text(
                    error,
                    style: TextStyle(
                      fontFamily: 'Architects',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                // set your custom alert dialog here
              ),
            ]);
      });
}
