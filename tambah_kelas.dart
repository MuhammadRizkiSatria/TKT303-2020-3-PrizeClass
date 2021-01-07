import 'dart:convert';

import 'package:claszious/Home%20Guru/home_guru.dart';
import 'package:claszious/Server/url_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddKelas extends StatefulWidget {
  @override
  _AddKelasState createState() => _AddKelasState();
}

class _AddKelasState extends State<AddKelas> {
  TextEditingController _kelas =TextEditingController();
  TextEditingController _wali =TextEditingController();

  int id ;
  getSave() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getInt("id");
    });
  }

  void initState() {
    super.initState();
    getSave();
  }

  Future AddKelas() async {
    final respon = await http.post(UrlAPI.add_kelas,body: {
      'kelas' : _kelas.text,
      'wali' : _wali.text,
      'id_guru' : id.toString()
    });

    final hasil = jsonDecode(respon.body);

    if ( respon.statusCode==200) {
      Alert(
          context: context,
          type: AlertType.success,
          title: "Informasi",
          desc: "Data Anda Berhasil Di Tambahkan",
          buttons: [
            DialogButton(
              child: Text("oke"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomeGuruPage()));
              },),
          ]
      ).show();
    } else {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Peringatan",
          desc: "Data Anda Gagal Di Tambahkan",
          buttons: [
            DialogButton(
              child: Text("oke"),
              onPressed: () => Navigator.pop(context),),
          ]
      ).show();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PRIZE CLASS",
              style: TextStyle(
                  color: Colors.deepOrange
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffF2F3F4),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 80, left: 50, right: 50),
                  child: Text('Form Tambah Kelas',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100, left: 50, right: 50),
                  child: TextFormField(
                    controller: _kelas,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Harap isi";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.class_),
                      hintText: 'Kelas',
                      hintStyle: TextStyle(fontSize: 15),
                      contentPadding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: TextFormField(
                    controller: _wali,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Harap isi";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Nama Wali',
                      hintStyle: TextStyle(fontSize: 15),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30,left: 80,right: 80),
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {
                      AddKelas();
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
                      child: Text("Tambah", style: TextStyle(
                          color: Colors.white)),
                    ),
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
