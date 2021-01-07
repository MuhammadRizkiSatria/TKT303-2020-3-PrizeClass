import 'package:claszious/Login/FadeAnimation.dart';
import 'package:claszious/Login/login_guru.php.dart';
import 'package:claszious/Login/login_siswa.dart';
import 'package:claszious/Register/register_guru.dart';
import 'package:claszious/Register/register_siswa.dart';
import 'package:flutter/material.dart';

class PilihRegister extends StatefulWidget {
  @override
  _PilihRegisterState createState() => _PilihRegisterState();
}

class _PilihRegisterState extends State<PilihRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Container(
                  height: 410,
                  child: Stack(
                    children: [
                      Positioned(
                          left :110,
                          width: 180,
                          height: 520,
                          child: FadeAnimation(1, Container(
                            width: 100,
                            height: 100,
                            child: Image(
                              image: AssetImage('assets/logo/logo2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),))
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Padding(
                        padding : EdgeInsets.only(top: 5, right: 100),
                        child: FadeAnimation(2, Text("Login Sebagai :",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),)
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: FadeAnimation(3,Container(
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.deepOrange,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 250.0, minHeight: 42.0),
                              alignment: Alignment.center,
                              child: Text("SISWA", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: FadeAnimation(4,Container(
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.deepOrange,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => LoginGuruPage()));
                            },
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 250.0, minHeight: 42.0),
                              alignment: Alignment.center,
                              child: Text("GURU", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
