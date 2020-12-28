import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeGuruPage extends StatefulWidget {
  final VoidCallback signOut;
  HomeGuruPage({this.signOut});
  @override
  _HomeGuruPageState createState() => _HomeGuruPageState();
}

class _HomeGuruPageState extends State<HomeGuruPage> {

  signOut(){
    setState(() {
      widget.signOut();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Guru",
              style: TextStyle(
                  color: Colors.black
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
    );
  }
}
