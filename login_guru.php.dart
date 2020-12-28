import 'dart:convert';

import 'package:claszious/Home%20Guru/home_guru.dart';
import 'package:claszious/Home%20Siswa/home_siswa.dart';
import 'package:claszious/Register/pilih_sebagai.dart';
import 'package:claszious/Register/register_guru.dart';
import 'package:claszious/Register/register_siswa.dart';
import 'package:claszious/Server/url_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FadeAnimation.dart';
import 'package:http/http.dart' as http;


class LoginGuruPage extends StatefulWidget {
  @override
  _LoginGuruPageState createState() => _LoginGuruPageState();
}

enum LoginStatus{
  notSignIn,
  signIn,
}

class _LoginGuruPageState extends State<LoginGuruPage> {

  LoginStatus _loginStatus= LoginStatus.notSignIn;

  bool lihatpass = true;
  var email, password;
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
      loginform();
    }
  }

  loginform() async {
    final respon = await http.post(UrlAPI.login_guru, body: {
      'email': email,
      'pass': password,
    });
    final hasil = jsonDecode(respon.body);


    bool status = hasil['error'];
    String pesan = hasil['message'];
    String page = hasil ['page'];
    int id = hasil['id'];
    String username = hasil['username'];


    Login() {
      setState(() {
        _loginStatus = LoginStatus.signIn;

        savePref(id, username,email, page, status);
      });

    }




    if (status == true) {
      Alert(
          context: context,
          type: AlertType.error,
          title: "PERINGATAN",
          desc: pesan,
          buttons: [
            DialogButton(
              child: Text("OKE"),
              onPressed: () => Navigator.pop(context),
              width: 120.0,
            )
          ]
      ).show();
    } else {
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
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              }
          )
        ],
      ).show();
    }
  }

  savePref(int id, String username, String email, String page,bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("id", id );
      preferences.setString("username", username);
      preferences.setString("email", email);
      preferences.setString("page", page);
      preferences.setBool("status", status);

    });
  }

  var status, id, page;

  getPres() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getBool("status");
      id = preferences.getInt("id");
      page = preferences.getString("page");
      _loginStatus = status == false ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("status", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getPres();
  }


  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Color(0xffF2F3F4),
          body: Form(
              key: keyform,
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 310,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/logo/bg.png'),
                                  fit: BoxFit.fill
                              )
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 110,
                                  width: 180,
                                  height: 420,
                                  child: FadeAnimation(1, Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/logo/logo 3.png')
                                        )
                                    ),
                                  )))
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(70),
                          child: Column(
                            children: [
                              FadeAnimation(2, TextFormField(
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return 'Harap mengisi Username';
                                  }
                                },
                                onSaved: (e) => email = e,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            32.0)),
                                    fillColor: Colors.grey,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: Colors.grey
                                    )
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
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
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              32.0)),
                                      suffixIcon: new IconButton(
                                        icon: new Icon(
                                          lihatpass
                                              ? FontAwesomeIcons.eyeSlash
                                              : FontAwesomeIcons.eye
                                          , color: Colors.black45,
                                          size: 20,),
                                        onPressed: () {
                                          lihatpassword();
                                        },
                                      ),
                                      fillColor: Colors.grey,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      )
                                  ),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: FadeAnimation(4, Container(
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: Colors.deepOrange,
                                    onPressed: () {
                                      validasi();
                                    },
                                    shape:
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 250.0, minHeight: 42.0),
                                      alignment: Alignment.center,
                                      child: Text("LOG IN", style: TextStyle(
                                          color: Colors.white)),
                                    ),
                                  ),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: FadeAnimation(4, Container(
                                  height: 50.0,
                                  child: RaisedButton(
                                    color: Colors.deepOrange,
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterGuruPage()));
                                    },
                                    shape:
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 250.0, minHeight: 42.0),
                                      alignment: Alignment.center,
                                      child: Text("REGISTER", style: TextStyle(
                                          color: Colors.white)),
                                    ),
                                  ),
                                )),
                              ),
                              FadeAnimation(5, Padding(padding: EdgeInsets.only(top: 30),
                                  child: RichText(
                                    text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                              child: Icon(FontAwesomeIcons.arrowLeft, color: Colors.deepOrange, size: 18,)),
                                          TextSpan(
                                              text: ' Back',
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 20,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PilihRegister()));
                                                }
                                          ),
                                        ]
                                    ),
                                  )
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
        break;
      case LoginStatus.signIn:
        return HomeGuruPage(signOut: signOut);
        break;
    }
  }
}

