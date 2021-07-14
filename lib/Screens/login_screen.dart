import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Constants/common_const.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool _showPassword = true;
  bool spinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#eff48e'),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Lets Fight Together  ',
                style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontSize: 50.0,

                    color: Colors.black),
              ),
              SizedBox(
                height: 25.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20),
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Enter your email',
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Hexcolor('#d2e603'), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Hexcolor('#d2e603'), width: 4.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                obscureText: _showPassword,
                style: TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(color: Colors.black, fontFamily: 'Architects',fontSize: 20.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: this._showPassword ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => this._showPassword = !this._showPassword);
                    },
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Hexcolor('#d2e603'), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Hexcolor('#d2e603'), width: 4.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
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
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, 'home');
                        }
                        setState(() {
                          spinner = false;

                        });
                      } catch (e) {
                        var error=e.message;
                        if(error==null)
                          error="Some fields are empty fill it";
                        setState(() {
                          spinner = false;
                          Errorbox(context, error);
                        });
                      }
                    },
                    minWidth: 200.0,
                    height: 50.0,
                    child: Text(
                      'Log In',
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
              GestureDetector(
                  child: Text(
                    "New to CONNECTOR_PH ",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Architects',
                        fontSize: 25.0,
                        color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'register');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
