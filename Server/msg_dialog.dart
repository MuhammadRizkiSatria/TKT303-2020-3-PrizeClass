import 'package:flutter/material.dart';

class MsgDialog{
  static void showMessageDialog(BuildContext context,
      String judul, String pesan){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(judul),
          content: Text(pesan),
          actions: <Widget>[
            new FlatButton(
              onPressed: (){
                //Keluar dialog
                Navigator.of(context).pop(MsgDialog);
              },
              child: Text('OK'),
            )
          ],
        )
    );
  }
}