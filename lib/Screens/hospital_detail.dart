import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:math' show cos, sqrt, asin;
import 'package:geolocator/geolocator.dart';
import '../Constants/common_const.dart';
import '../Constants/hospital_detail_constant.dart';

Map<String, dynamic> mp;
Position userLoc;
// ignore: must_be_immutable
class Details extends StatefulWidget {
  Map<String, dynamic> HospName;
  Position location;

  Details({Key key, @required this.HospName,@required this.location }) : super(key: key) {
    mp = HospName;
    userLoc=location;
  }

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int number;
  var a,b;
  String email;
  int total = 0;
  List<String> img = List();
  String url;
  String distance ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processData();
    //  getData();
  }

  void processData() async {
    total = int.parse(mp['Total Beds']) + int.parse(mp['Total Icu']);
    number = int.parse(mp['Contact']);
    email = mp['Email'];
    img.add(mp['Img1']);
    img.add(mp['Img2']);
    img.add(mp['Img3']);
    img.add(mp['Img4']);
    a = double.tryParse(mp['Lat']);
    b = double.tryParse(mp['Long']);

    distance=calculateDistance(a, b, userLoc.latitude, userLoc.longitude);
    double c= userLoc.latitude;
    double d= userLoc.longitude;
    url = "https://www.google.com/maps/dir/?api=1&origin=" + '$a'+","+'$b' + "&destination=" +'$c'+","+'$d' + "&travelmode=driving";
  }
  String calculateDistance(lat1, lon1,lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return (12742 * asin(sqrt(a))).toStringAsFixed(2);
  }

//  void getData() async {
//
//    final snapshots = await _store
//        .collection("Hospitals")
//        .where('Name', isEqualTo: name)
//        .get();
//
//    for (var m in snapshots.docs) {
//      mp = m.data();
//      print(m.data());
//    }
//    setState(() {
//      spinner=false;
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Hexcolor('#eff48e'),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Hexcolor('#d2e603'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.black,
                ),
                onPressed: () {
                  UrlLauncher.launch("mailto:$email");
                }),
            IconButton(
                icon: Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                onPressed: () {
                  UrlLauncher.launch("tel:$number");
                }),
          ],
          title: Text(
            mp['Name'],
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Architects',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'bot');
          },
          child: Icon(Icons.chat, color: Colors.black),
          backgroundColor: Hexcolor('#d2e603'),
        ),
        body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 350,
                    child: ListView(children: <Widget>[
                      SizedBox(height: 15.0),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 350.0,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 11,
                            initialPage: 0,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn),
                        items: [
                          ImgList(img[0]),
                          ImgList(img[1]),
                          ImgList(img[2]),
                          ImgList(img[3]),
                        ],
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton.icon(
                        onPressed: () {
                          UrlLauncher.launch(url);
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Hexcolor('#3e978b'),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                        icon: Icon(
                          Icons.location_on_sharp,
                          size: 30.0,
                        ),
                        label: Text(
                          distance+' km',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Architects',
                          ),
                        ),
                      ),
                      StarRating(mp['Ratings'])
                    ]),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('TOTAL AVAILABILITY:  ' + '$total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Architects',
                      fontWeight: FontWeight.w700)),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('ABOUT US  ',textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 27.0,
                        fontFamily: 'Architects',
                        fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("  " + mp['Description'],textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Architects',
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 10.0,
              ),
              WardsFont('Icu'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: BoxCard(int.parse(mp['Total Icu']), 'Available',
                            30.0, 150.0)),
                    Expanded(
                        child: BoxCard(
                            int.parse(mp['Icu']), 'Vacant', 30.0, 150.0))
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              WardsFont('Beds'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: BoxCard(int.parse(mp['Total Beds']), 'Available',
                            55.0, 150.0)),
                    Expanded(
                        child: BoxCard(
                            int.parse(mp['Beds']), 'Vacant', 55.0, 150.0)),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Consulting Timings:  " + mp['Timings'],
                  style: TextStyle(
                    fontFamily: 'Architects',
                    color: Colors.black,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ]));
  }
}
