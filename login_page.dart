import 'package:flutter/material.dart';
import 'package:tokobuku/page/login_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log Out'),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (Route<dynamic> route)=>false);
          },
        ),
      ),
    );
  }
}
