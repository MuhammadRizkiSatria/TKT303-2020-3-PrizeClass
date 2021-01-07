import 'dart:convert';

import 'package:claszious/Login/FadeAnimation.dart';
import 'package:claszious/Login/login_siswa.dart';
import 'package:claszious/Server/url_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';


class RegisterGuruPage extends StatefulWidget {
  @override
  _RegisterGuruPageState createState() => _RegisterGuruPageState();
}

class _RegisterGuruPageState extends State<RegisterGuruPage> {

  bool lihatpass = true;
  var username, password, email;
  final keyform = GlobalKey<FormState>();

  lihatpassword() {
    setState(() {
      lihatpass = !lihatpass;
    });
  }

  validasi() {
    final form = keyform.currentState;
    if (form.validate()) {
      form.save();
      registerForm();
    }
  }

  registerForm() async {
    final respon = await http.post(UrlAPI.register_guru, body: {
      'username': username,
      'email': email,
      'pass': password,

    });

    final hasil = jsonDecode(respon.body);
    bool status1 = hasil["error"];
    String pesan = hasil["message"];

    if (status1 == true){
      Alert(
        context: context,
        type: AlertType.error,
        title: "PERINGATAN",
        desc: pesan,
        buttons: [
          DialogButton(
            child: Text(
              "OKE",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }else{
      Alert(
        context: context,
        type: AlertType.info,
        title: "INFORMASI",
        desc: pesan,
        buttons: [
          DialogButton(
            child: Text(
              "OKE",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage())),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: keyform,
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Container(
                    height: 210,
                    child: Stack(
                      children: [
                        Positioned(
                            left :110,
                            width: 180,
                            height: 320,
                            child: FadeAnimation(1, Container(
                              decoration: BoxDecoration(
                                image:DecorationImage(
                                  image: AssetImage('assets/logo/logo 3.png'),
                                ),
                              ),
                            )))
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 70, left: 50, right: 50),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top :8.0),
                          child: FadeAnimation(3, TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'Harap mengisi Username';
                              }
                            },
                            onSaved: (e) => username = e,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                fillColor: Colors.grey,
                                hintText:"Username",
                                hintStyle:TextStyle(
                                    color:Colors.grey
                                )
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top :8.0),
                          child: FadeAnimation(3, TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'Harap mengisi Password';
                              }
                            },
                            onSaved: (e) => password = e,
                            keyboardType: TextInputType.text,
                            obscureText: lihatpass,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                suffixIcon: new IconButton(
                                  icon: new Icon(
                                    lihatpass ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye
                                    , color: Colors.black45,
                                    size: 20,),
                                  onPressed: () {
                                    lihatpassword();
                                  },
                                ),
                                fillColor: Colors.grey,
                                hintText:"Password",
                                hintStyle:TextStyle(
                                    color:Colors.grey
                                )
                            ),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top :8.0),
                          child: FadeAnimation(3, TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'Harap mengisi Email';
                              }
                            },
                            onSaved: (e) => email = e,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                fillColor: Colors.grey,
                                hintText:"Email",
                                hintStyle:TextStyle(
                                    color:Colors.grey
                                )
                            ),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: FadeAnimation(4,Container(
                            height: 50.0,
                            child: RaisedButton(
                              color: Colors.deepOrange,
                              onPressed: () {validasi();},
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 250.0, minHeight: 42.0),
                                alignment: Alignment.center,
                                child: Text("REGISTER", style: TextStyle(color: Colors.white)),
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
                                    MaterialPageRoute(builder: (context) => LoginPage()));
                              },
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 250.0, minHeight: 42.0),
                                alignment: Alignment.center,
                                child: Text("LOG IN", style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}
