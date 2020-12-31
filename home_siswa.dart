import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:claszious/Chat/chat.dart';
import 'package:claszious/Home%20Siswa/poin_siswa.dart';
import 'package:claszious/Mapel/mapel.dart';
import 'package:claszious/Server/url_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class HomeSiswaPage extends StatefulWidget {
  String name;
  final VoidCallback signOut;
  HomeSiswaPage({this.signOut});
  @override
  _HomeSiswaPageState createState() => _HomeSiswaPageState();
}

class _HomeSiswaPageState extends State<HomeSiswaPage> {
  int id ;
  String username ;
  String email;
  getSave() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getInt("id");
      username = preferences.getString("username");
      email = preferences.getString("email");

    });
  }

  Future<Null> refreshData() async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getMapel();
    });
  }

  var test;

  Future<List> getMapel() async{
    final respon = await http.post(UrlAPI.getMapel, body: {});

    test = json.decode(respon.body);

    return json.decode(respon.body);

  }

  void initState() {
    super.initState();
    getSave();
  }
  signOut(){
    setState(() {
      widget.signOut();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEDED),
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
        actions: <Widget>[
          IconButton(
            onPressed: (){signOut();},
            icon: Icon(FontAwesomeIcons.signOutAlt,color: Colors.black,),
          ),
        ],
      ),
      body: Stack(
        children: [
          Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 50),
                  width: 120,
                  height: 200,
                  child: Column(
                    children: [
                      Divider(),
                      GridView.count(
                        crossAxisCount: 1,
                        shrinkWrap: true,
                        primary: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          GestureDetector(
                            child: CircularProfileAvatar(
                              '',
                              borderWidth: 2,
                              radius: 100,
                              borderColor: Colors.black,
                              elevation: 5.0,
                            ),
                            onTap: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 30, top: 400)),
              Text(username.toString(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(left : 150.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return PoinSiswa();
                          }
                        )
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        color: Colors.white ,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    width: 135,
                    height: 50,
                    alignment: Alignment.center,
                    child: Column(
                        children: <Widget>[

                          Text("My Point",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ) ,),
                          Padding(padding: EdgeInsets.only(bottom: 5)),
                        ]),
                  ),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 250, left: 40),
            child: Row(
            children: [
              Column(
                children: [
                  Text("11a",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text("kelas",
                  style: TextStyle(
                    fontSize: 20
                  ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 35),
                child: Column(
                  children: [
                    IconButton(
                        icon: Icon(FontAwesomeIcons.comments, color: Colors.black,),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) {
                                return Pesan();
                              }
                              )
                          );
                        }),
                    Text("chat",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 45)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Column(
                  children: [
                    Text("150",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text("point",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 320.0),
                child: Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                  // width: 100,
                  // height: 100,
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: refreshData,
                        child: FutureBuilder<List>(
                          future: getMapel(),
                          builder: (context, snapshot) {
                          if(snapshot.hasError) print(snapshot.error);

                          return Center(
                            child: snapshot.hasData == null ? 0 : MapelList(list: snapshot.data),
                          );
                          },
                          ),
                        ),
                    ),
                  ),
              ),
              )
        ],
      ),
    );
  }
}

class MapelList extends StatelessWidget {
  final List list;
  MapelList({this.list});
  @override
  Widget build(BuildContext context) {
    var id_mapel;
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.all(5),
            child: FlatButton(
              onPressed: () {
                id_mapel = list[i]['id'].toString();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
//                  print(id_pengaduan);
                    return ViewMapel(id: id_mapel,index: i,);
                  }),
                );
              },
              child: Container (
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                height: 70,
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
                    Container(
                      width: 150,
                      child: Text(list[i]['mapel'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 150),
                      child: Text(list[i]['jml_soal'],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

