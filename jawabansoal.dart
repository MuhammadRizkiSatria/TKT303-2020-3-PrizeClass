import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:inputsoal_app/url/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class HalamanJawabanP extends StatefulWidget {
  final String id_mpl,plj;
  HalamanJawabanP({Key key, this.id_mpl,this.plj}) : super(key: key);

  @override
  _HalamanJawabanPState createState() => _HalamanJawabanPState();
}
class Jawaban {
  String name;
  int index;
  Jawaban({this.name, this.index});
}
class _HalamanJawabanPState extends State<HalamanJawabanP> {

  var pilih,id;

  final key = UniqueKey();

  Future<List> tampilsoal() async{
    final respon = await http.post(UrlAPI.tampilsoalP,body: {
      'id_pelajaran'    : widget.id_mpl.toString()
    });
    return json.decode(respon.body);
  }
  // String radioItem;
  // void pilihan(){
  //   setState(() {
  //     if (radioItem == true && id == id){
  //       radioItem = 'A';
  //     }else if(radioItem == true && id == id){
  //       radioItem = 'B';
  //     }else if(radioItem == true && id == id){
  //       radioItem = 'C';
  //     }else if(radioItem == true && id == id){
  //       radioItem = 'D';
  //     }
  //     print(radioItem);
  //
  //   });
  // }

  // Default Radio Button Item
  String radioItem = '';

  // Group Value for Radio Button.
  int id_jawaban = 1;

  List<Jawaban> fList = [
    Jawaban(
      index: 1,
      name: "A",
    ),
    Jawaban(
      index: 2,
      name: "B",
    ),
    Jawaban(
      index: 3,
      name: "C",
    ),
    Jawaban(
      index: 4,
      name: "D",
    ),
  ];

  void pilihan(){
    if (select == radioItem && id==id_jawaban){
      select = true;
    }else{
      select = false;
    }
    print(select);

  }
  bool select = false;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemheigth = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Soal Pilihan Ganda "+ widget.plj),
        backgroundColor: Colors.blue,
      ),
      body:  SafeArea(
        child: Container(
          height: itemheigth,
          child: FutureBuilder<List>(
            future: tampilsoal(),
            builder: (context, snapshot){
              if (snapshot.hasError) print(snapshot.error);

              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data == null ? 0 :snapshot.data.length,
                  itemBuilder: (context, baris){
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: (){
                              id = snapshot.data[baris]['id_soal'];
                              print(id);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(4.0, 4.0),
                                      spreadRadius: 1
                                    )
                                  ]
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(snapshot.data[baris]['soal'])
                                        ),
                                        Container(
                                          height: 350.0,
                                          child: Column(
                                            children:
                                            fList.map((data) => RadioListTile(
                                              title: Text("${data.name}"),
                                              selected: select,
                                              groupValue: id_jawaban,
                                              value: data.index,
                                              onChanged: (val) {
                                                setState(() {
                                                  radioItem = data.name ;
                                                  id_jawaban = data.index;
                                                  id = snapshot.data[baris]['id_soal'];
                                                 print(id);
                                                 print(radioItem);
                                                 pilihan();
                                                });
                                              },
                                            )).toList(),
                                          ),
                                        ),
                                      ],
                                    )
                                )),
                          )),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class JawabanJawabanE extends StatefulWidget {
  final String id_mpl,plj;
  JawabanJawabanE({this.id_mpl,this.plj});
  @override
  _JawabanJawabanEState createState() => _JawabanJawabanEState();
}

class _JawabanJawabanEState extends State<JawabanJawabanE> {
  final _controller = TextEditingController();
  final keyform =GlobalKey<FormState>();
  var jawaban,id;

  Future<List> tampilsoal() async{
    final respon = await http.post(UrlAPI.tampilsoalE, body: {
      'id_pelajaran'    : widget.id_mpl.toString()
    });
    return json.decode(respon.body);
  }

  Future<List>kirimjawaban()async{
    final respon = await http.post(UrlAPI.inputjawabanE, body: {
      'id_user'    : "1",
      'id_soal'    : id.toString(),
      'jawaban'    : jawaban.toString()
    });
    final hasil = jsonDecode(respon.body);
    bool status1 = hasil["error"];
    String pesan = hasil["message"];
    print(respon.body);

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
        desc: pesan,
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
      kirimjawaban();
      _controller.text = "";
    }
  }
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            height: 400,
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                   key: keyform,
                    child: TextFormField(
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                      controller: _controller ,
                      validator: (e){
                        if(e.isEmpty){
                          return 'MASUKKAN JAWABAN ANDA';
                        }
                      },
                      onSaved: (e)=> jawaban = e ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        filled: true,
                        hintText:"Masukkan Jawaban Anda",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
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
                        child: Center(child: Text('KIRIM',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                      ),
                    )
                  ),
                )
              ],
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemheigth = size.height;
    final double widt = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Soal Essay "+widget.plj),
        backgroundColor: Colors.blue,
      ),
      body:  SafeArea(
        child: Container(
          height: itemheigth,
          child: FutureBuilder<List>(
            future: tampilsoal(),
            builder: (context, snapshot){
              if (snapshot.hasError) print(snapshot.error);
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data == null ? 0 :snapshot.data.length,
                  itemBuilder: (context, baris){
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width:widt ,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        offset: Offset(4.0, 4.0),
                                        spreadRadius: 1
                                    )
                                  ]
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                            title: Text(snapshot.data[baris]['soal']),
                                          trailing: IconButton(
                                            onPressed: (){
                                              id = snapshot.data[baris]['id_soal_e'];
                                              _settingModalBottomSheet(context);
                                              print(id);
                                            },
                                            icon: Icon(Icons.question_answer),
                                          ),
                                        ),
                                      ))
                              )
                          )
                      ),
                    );
                  },
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}

