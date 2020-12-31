import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:inputsoal_app/daftarpelajaran.dart';
import 'package:inputsoal_app/url/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'jawabansoal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DaftarPelajaran(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String id_mpl,plj;
  MyHomePage({
    this.plj,this.id_mpl
});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOAL " + widget.plj),
        backgroundColor: Colors.blue,
      ),

      drawer: Drawer(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                     // borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blue[100],
                          Colors.blue[200],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      // shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[600],
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4.0, 4.0), // changes position of shadow
                        ),
                        BoxShadow(
                          color: Colors.grey[600],
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(-4.0, -4.0), // changes position of shadow
                        ),
                      ],
                    ),
                    child:  Image.network(
                      "https://images.pexels.com/photos/4067768/pexels-photo-4067768.jpeg?cs=srgb&dl=pexels-cottonbro-4067768.jpg&fm=jpg",
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,

                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: Colors.blue,
                //           borderRadius: BorderRadius.circular(10)
                //       ),
                //       child:  FlatButton(
                //         color: Colors.blue,
                //         child: Text("Tambah Soal Pilihan Ganda",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                //         onPressed: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context)=>TambahSoal()));
                //         },
                //       ),
                //     )
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: FlatButton(
                        child: Text("Tambah Tugas ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TambahSoalEssay()));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: GestureDetector(
          //     onTap: (){
          //
          //         Navigator.push(context, MaterialPageRoute(builder: (context)=>HalamanJawabanP(id_mpl: widget.id_mpl,plj:widget.plj,)));
          //     },
          //     child: Container(
          //       height: 50,
          //       decoration:BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(20)
          //       ) ,
          //       child: Center(child: Text("SOAL PILIHAN GANDA",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>JawabanJawabanE(id_mpl: widget.id_mpl,plj:widget.plj,)));
              },
              child: Container(
                height: 50,
                decoration:BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)
                ) ,
                child: Center(child: Text("JAWAB SOAL ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class TambahSoal extends StatefulWidget {
  @override
  _TambahSoalState createState() => _TambahSoalState();
}

class _TambahSoalState extends State<TambahSoal> {
  final keyform = GlobalKey<FormState>();
  var soal,jawaban,plj,id_plj;
  final saolcontroll = TextEditingController();
  final jawabcontroll = TextEditingController();

  kirimsoal()async{
    final respon = await http.post(UrlAPI.tambahsoal, body: {
      'id_pelajaran'  : id_plj.toString(),
      'soal'          : soal.toString(),
      'jawaban'       : jawaban.toString()
    });
    final hasil = jsonDecode(respon.body);
    bool status1 = hasil["error"];
    String pesanerror = hasil["message"];
    print(respon.body);
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
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  String satuan;
  List<dynamic>_dataSatuan = List();
  void getProvince()async{
    final response = await http.post(UrlAPI.tampilplj);
    var listData = jsonDecode(response.body);
    setState(() {
      _dataSatuan = listData;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvince();
  }

  validasi(){
    final form = keyform.currentState;
    if(form.validate()){
      form.save();
      kirimsoal();
      saolcontroll.text ="";
      jawabcontroll.text ="";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INPUT SOAL PILIHAN GANDA"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Form(
          key: keyform,
          child:ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.list, color: Colors.black,),
                      value: satuan,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                      ),
                      hint: Text(
                        '----Pilih Mata Pelajaran----',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onChanged: (val){
                        setState(() {
                          satuan = val;


                        });
                      },
                      items: _dataSatuan.map((value){
                        return DropdownMenuItem(
                          child: Text(value['pelajar']),
                          value: value['id_mpl'],
                          onTap: (){
                            setState(() {
                              plj = value['pelajar'];
                              id_plj = value['id_mpl'];
                              print(plj);
                              print(id_plj);
                            });
                          },
                        );
                      })?.toList() ??
                          [],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: saolcontroll,
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
                  controller: jawabcontroll,
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
            ],
          ) ,
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          validasi();
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
                borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child: Text("SIMPAN",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 19),)),
        ),
      ),
    );
  }
}



class TambahSoalEssay extends StatefulWidget {
  @override
  _TambahSoalEssayState createState() => _TambahSoalEssayState();
}

class _TambahSoalEssayState extends State<TambahSoalEssay> {
  final keyform = GlobalKey<FormState>();
  var soal,jawaban,plj,id_plj;
  final saolcontroll = TextEditingController();
  final jawabcontroll = TextEditingController();

  kirimsoal()async{
    final respon = await http.post(UrlAPI.tambahsoalessay, body: {
      'id_pelajaran'  : id_plj.toString(),
      'soal'          : soal.toString(),
      'jawaban'       : jawaban.toString()
    });
    final hasil = jsonDecode(respon.body);
    bool status1 = hasil["error"];
    String pesanerror = hasil["message"];
    print(respon.body);
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
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  String satuan;
  List<dynamic>_dataSatuan = List();
  void getProvince()async{
    final response = await http.post(UrlAPI.tampilplj);
    var listData = jsonDecode(response.body);
    setState(() {
      _dataSatuan = listData;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvince();
  }



  validasi(){
    final form = keyform.currentState;
    if(form.validate()){
      form.save();
      kirimsoal();
      saolcontroll.text ="";
      jawabcontroll.text ="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INPUT SOAL ESSAY"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Form(
          key: keyform,
          child:ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.list, color: Colors.black,),
                      value: satuan,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                      ),
                      hint: Text(
                        '-----Pilih Mata Pelajaran---',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onChanged: (val){
                        setState(() {
                          satuan = val;


                        });
                      },
                      items: _dataSatuan.map((value){
                        return DropdownMenuItem(
                          child: Text(value['pelajar']),
                          value: value['id_mpl'],
                          onTap: (){
                            setState(() {
                              plj = value['pelajar'];
                              id_plj = value['id_mpl'];
                              print(plj);
                              print(id_plj);
                            });
                          },
                        );
                      })?.toList() ??
                          [],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: saolcontroll,
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
                  controller: jawabcontroll,
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
            ],
          ) ,
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          validasi();
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child: Text("SIMPAN",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 19),)),
        ),
      ),
    );
  }
}

class TambahPelajaran extends StatefulWidget {
  @override
  _TambahPelajaranState createState() => _TambahPelajaranState();
}

class _TambahPelajaranState extends State<TambahPelajaran> {
  final keyform = GlobalKey<FormState>();
  var soal,guru,plj,id_plj;
  final saolcontroll = TextEditingController();
  final jawabcontroll = TextEditingController();

  kirimsoal()async{
    final respon = await http.post(UrlAPI.tambahplj, body: {
      'pelajaran'     : plj.toString(),
      'guru'          : guru.toString(),
    });
    final hasil = jsonDecode(respon.body);
    bool status1 = hasil["error"];
    String pesanerror = hasil["message"];
    print(respon.body);
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
              Navigator.pop(context);
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
      kirimsoal();
      saolcontroll.text ="";
      jawabcontroll.text ="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("TAMBAH PELAJARAN"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Form(
          key: keyform,
          child:ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: saolcontroll,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  validator: (e){
                    if(e.isEmpty){
                      return 'MASUKKAN MATA PELAJARAN';
                    }
                  },
                  onSaved: (e)=> plj = e ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true,
                    hintText:"Masukkan Mata Pelajaran",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: jawabcontroll,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  validator: (e){
                    if(e.isEmpty){
                      return 'MASUKKAN NAMA GURU';
                    }
                  },
                  onSaved: (e)=> guru = e ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    filled: true,
                    hintText:"Masukkan Nama Guru",
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ) ,
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          validasi();
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child: Text("SIMPAN",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 19),)),
        ),
      ),
    );
  }
}
