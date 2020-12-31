import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PoinSiswa extends StatefulWidget {
  @override
  _PoinSiswaState createState() => _PoinSiswaState();
}

class _PoinSiswaState extends State<PoinSiswa> {
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
                    color: Colors.black
                ),
              ),
            ],
          ),
      ),
      backgroundColor: Color(0xffEAEDED),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15 , right: 15, top: 50),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                height: 300,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius : BorderRadius.circular(30),
                    boxShadow: [BoxShadow(
                        color: Colors.black12,
                        blurRadius: 30.0,
                        offset: Offset(0, 20)
                    )]
                ),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image(
                          image: AssetImage('assets/logo/tropi.png'),
                      fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20, left: 15),
                          child: Text('-   Point Hari Ini 320'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5, left: 15),
                          child: Text('-   20 Soal di jawab minggu ini'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left : 200.0, top: 20),
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
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(
                          color: Colors.black12,
                          blurRadius: 30.0,
                          offset: Offset(0, 20)
                      )]
                  ),
                  width: 170,
                  height: 50,
                  alignment: Alignment.center,
                  child: Column(
                      children: <Widget>[

                        Text("Klaim Hadiah",
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
      ),
    );
  }
}
