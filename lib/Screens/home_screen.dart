import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectorph/screens/welcome_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'city_screen.dart';
import 'hospital_detail.dart';
import '../Constants/home_screen_const.dart';
import '../Constants/common_const.dart';
User loggedInUser;
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map> HospDetails = List();
  String Userdistrict='Empty';
  String UserName= 'Null';
  String UserMail ='Null';
  num availBed = 0;
  num totalHos = 0;
  num filledBed = 0;
  bool spinner = true;
  Position user;
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getUser();
    getLocation();

  }
  void getUser() async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        final snapshots = await _store.collection("Users").where('MailId', isEqualTo: loggedInUser.email).get();
        for (var m in snapshots.docs) {
          var t = m.data();
          setState(() {
            UserName=t['User'];
            UserName= UserName[0].toUpperCase()+UserName.substring(1).toLowerCase();
            UserMail=loggedInUser.email;
          });

        }
      }
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    availBed = totalHos = filledBed = 0;
    HospDetails.clear();
    final snapshots = await _store.collection("Hospitals").where('District', isEqualTo: Userdistrict).get();

    for (var m in snapshots.docs) {
      var t = m.data();
      HospDetails.insert(0, t);
      setState(() {
        availBed += int.parse(t['Beds']) + int.parse(t['Icu']);
        totalHos++;
        filledBed += int.parse(t['Total Beds']) + int.parse(t['Total Icu']);
      });
    }
    setState(() {
      filledBed -= availBed;

    });
    if (Userdistrict != null) {
      spinner = false;
    }
  }

  Future getLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    user=position;
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    Userdistrict = first.subAdminArea;


    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Hexcolor('#eff48e'),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () async {
                  var location = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CityScreen();
                      },
                    ),
                  );
                  setState(() {
                    Userdistrict = location;
                    Userdistrict= Userdistrict[0].toUpperCase()+Userdistrict.substring(1).toLowerCase();
                    getData();
                  });
                },
                child: Icon(
                  Icons.location_city,
                  color: Colors.black,
                )),
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                }),
          ],
          title: Text(
            'Connector_PH',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Architects',
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Hexcolor('#d2e603'),
        ),
        drawer: Drawer(
          child: ListView(

            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Text('Hello '+ UserName,style: TextStyle(
                      fontSize:40.0,
                      fontFamily: 'Architects',
                    ),),
                    Text(UserMail,style: TextStyle(
                      fontSize:20.0,
                      fontFamily: 'Architects',
                    ),),
                  ],
                ),
                decoration: BoxDecoration(
                  color:  Hexcolor('#d2e603'),
                ),
              ),
              ListTile(
                title: Text('Image Predection', style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Architects',

                ),),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              buildDivider(),
              ListTile(
                title: Text('COVID 🤓 Stories',style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Architects',

                ),),
                onTap: () {
                  Navigator.pushNamed(context, 'stories');
                },
              ),
              buildDivider(),
              ListTile(
                title: Text('Logout',style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'Architects',

                ),),
                onTap: () {
                  _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
              ),
              buildDivider(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'bot');
          },
          child: Icon(Icons.chat, color: Colors.black),
          backgroundColor: Hexcolor('#d2e603'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Row(
                  children: [
                    Expanded(
                        child: BoxCard(availBed, 'Available', 55.0, 150.0)),
                    Expanded(child: BoxCard(filledBed, 'Filled', 55.0, 150.0))
                  ],
                ),
                BoxCard(totalHos, 'Hospitals in ' + Userdistrict.toUpperCase(),
                    0, 130.0),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Hospital List 🏥',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: totalHos,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(HospName: HospDetails[index],location:user)),
                            );
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Hexcolor('#3e978b'), width: 2.0),
                                //new Color.fromRGBO(255, 0, 0, 0.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Hexcolor('#3e978b'),
                                    blurRadius: 10.0,
                                  ),
                                ],
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(10.0))),
                            margin: EdgeInsets.all(15.0),
                            height: 150.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Image.asset('images/hospital.jpg'),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      HospDetails[index]['Name'],
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'ZillaSlab',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),

                                    HospitalCard(HospDetails[index]['Beds'],'Vacant Beds : '),
                                    HospitalCard(HospDetails[index]['Icu'],'Vacant ICU : '),
                                    HospitalCard(HospDetails[index]['Cost'] +
                                        '/pre day','Avg Cost : '),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    StarRating(HospDetails[index]['Ratings'])
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ])),
        ));
  }


}
