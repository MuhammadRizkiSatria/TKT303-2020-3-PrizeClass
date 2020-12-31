import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:inputsoal_app/daftarpelajaran.dart';
import 'package:inputsoal_app/main.dart';
import 'package:inputsoal_app/url/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'jawabansoal.dart';

class DaftarPelajaran extends StatefulWidget {
  @override
  _DaftarPelajaranState createState() => _DaftarPelajaranState();
}

class _DaftarPelajaranState extends State<DaftarPelajaran> {
var id_mpl,plj;

  Future<List> tampilpelajaran() async{
    final respon = await http.post(UrlAPI.tampilplj);
    return json.decode(respon.body);
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemheigth = size.height;
    final double widt = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("DAFTAR PELAJARAN"),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  FlatButton(
                    color: Colors.blue,
                    child: Text("Tambah Pelajaran",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TambahPelajaran()));
                    },
                  ),
                )
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: itemheigth,
          child: FutureBuilder<List>(
            future: tampilpelajaran(),
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
                                          title: Text(snapshot.data[baris]['pelajar']),
                                          trailing:
                                          IconButton(
                                            onPressed: (){
                                              plj = snapshot.data[baris]['pelajar'];
                                              id_mpl = snapshot.data[baris]['id_mpl'];
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(id_mpl: id_mpl,plj:plj,)));

                                            },
                                            icon: Icon(Icons.question_answer_outlined),
                                          ),
                                        ),
                                      ))
                              ))),
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
//
// class DaftarPelajaranP extends StatefulWidget {
//   @override
//   _DaftarPelajaranPState createState() => _DaftarPelajaranPState();
// }
//
// class _DaftarPelajaranPState extends State<DaftarPelajaranP> {
//   var id_mpl,plj;
//
//   Future<List> tampilpelajaran() async{
//     final respon = await http.post(UrlAPI.tampilplj);
//     return json.decode(respon.body);
//   }
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemheigth = size.height;
//     final double widt = size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("DAFTAR PELAJARAN"),
//         backgroundColor: Colors.blue,
//       ),
//       body: SafeArea(
//         child: Container(
//           height: itemheigth,
//           child: FutureBuilder<List>(
//             future: tampilpelajaran(),
//             builder: (context, snapshot){
//               if (snapshot.hasError) print(snapshot.error);
//               return Center(
//                 child: ListView.builder(
//                   itemCount: snapshot.data == null ? 0 :snapshot.data.length,
//                   itemBuilder: (context, baris){
//                     return Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                               width:widt ,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey,
//                                         blurRadius: 10,
//                                         offset: Offset(4.0, 4.0),
//                                         spreadRadius: 1
//
//                                     )
//                                   ]
//                               ),
//                               child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: ListTile(
//                                           title: Text(snapshot.data[baris]['pelajar']),
//                                           trailing: IconButton(
//                                             onPressed: (){
//                                               plj = snapshot.data[baris]['pelajar'];
//                                               id_mpl = snapshot.data[baris]['id_mpl'];
//                                               Navigator.push(context, MaterialPageRoute(builder: (context)=>HalamanJawabanP(id_mpl: id_mpl,plj: plj,)));
//                                             },
//                                             icon: Icon(Icons.question_answer_outlined),
//                                           ),
//                                         ),
//                                       ))
//                               ))),
//                     );
//                   },
//                 ),
//               );
//
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
