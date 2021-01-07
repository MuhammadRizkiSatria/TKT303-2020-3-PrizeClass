import 'dart:convert';

import 'package:claszious/Home%20Guru/home_guru.dart';
import 'package:claszious/Server/url_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class ViewSoal extends StatefulWidget {
  final String id_mapel;

  const ViewSoal({Key key, this.id_mapel}) : super(key: key);
  @override
  _ViewSoalState createState() => _ViewSoalState();
}

class _ViewSoalState extends State<ViewSoal> {
  _ViewSoalState();


  Future<List> tampilsoal() async{
    final respon = await http.post(UrlAPI.viewSoal, body: {
      'id_mapel'    : widget.id_mapel
    });
    return json.decode(respon.body);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemheigth = size.height;
    final double width = size.width;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget> [
          IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.deepOrange,),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeGuruPage()));
            }, )
        ],
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PRIZE CLASS",
              style: TextStyle(
                  color: Colors.orange
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 680,
                child: FutureBuilder<List>(
                  future: tampilsoal(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return Center(
                      child: ListView.builder(
                          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Container(
                                padding: EdgeInsets.all(10),
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(5),
                                height: 100,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius : BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 30.0,
                                        offset: Offset(0, 20)
                                    )]
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 320,
                                          height: 50,
                                          child: Text(snapshot.data[i]['soal'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 320,
                                          height: 20,
                                          child: Text('Jawaban : ' + snapshot.data[i]['jawaban'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 320,
                                          height: 10,
                                          child: Text( snapshot.data[i]['tgl'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text('Poin',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),Text(snapshot.data[i]['poin'],
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 220),
                child: Container(
                  height: 50.0,
                  width: 200,
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddSoal(id_mapel: widget.id_mapel,)));
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
                      child: Text("Tambah Soal", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      )),
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}


class AddSoal extends StatefulWidget {
  final String id_mapel;

  const AddSoal({Key key, this.id_mapel}) : super(key: key);
  @override
  _AddSoalState createState() => _AddSoalState();
}

class _AddSoalState extends State<AddSoal> {
  final keyform = GlobalKey<FormState>();
  var soal,jawaban,poin;

  Future AddSoal() async {
    final respon = await http.post(UrlAPI.add_soal, body: {
      'id_mapel' : widget.id_mapel,
      'soal' : soal.toString(),
      'jawaban' : jawaban.toString(),
      'poin' : poin.toString()
    });
    final hasil = jsonDecode(respon.body);
    bool status1 = hasil["error"];
    String pesanerror = hasil["message"];
    if (status1 == true){
      Alert(
        context: context,
        type: AlertType.error,
        title: "PERINGATAN",
        desc: pesanerror,
        buttons: [
          DialogButton(
            child: Text(
              "OKE",
              style: TextStyle(color: Colors.white, fontSize: 20),
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
        desc: pesanerror,
        buttons: [
          DialogButton(
            child: Text(
              "OKE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewSoal(id_mapel: widget.id_mapel,)));
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  validasi(){
    final form = keyform.currentState;
    if(form.validate()){
      form.save();
      AddSoal();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PRIZE CLASS",
              style: TextStyle(
                  color: Colors.orange
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: keyform,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  validator: (e){
                    if(e.isEmpty){
                      return 'MASUKKAN SOAL';
                    }
                  },
                  onSaved: (e)=> soal = e ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true,
                    hintText:"Masukkan Soal",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  validator: (e){
                    if(e.isEmpty){
                      return 'MASUKKAN JAWABAN';
                    }
                  },
                  onSaved: (e)=> jawaban = e ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true,
                    hintText:"Masukkan Jawaban",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Text('Jumlah Poin :'),
                  Container(
                    width: 70,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        validator: (e){
                          if(e.isEmpty){
                            return 'MASUKKAN JAWABAN';
                          }
                        },
                        onSaved: (e)=> poin = e ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 200),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () {validasi();},
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
                          color: Colors.white,
                          fontSize: 20
                      )),
                    ),
                  ),
                ),)
            ],
          ),
        ),
      ),
    );
  }
}

