import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var _x;
  void refresh() async {
    _x=  await readData();
    setState(() {
   _x=_x;
   print(readData());
  });
  }

  Widget build(BuildContext context) {
    var _editingcontroller= new TextEditingController();
    return (new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amberAccent,
        title: new Text("FILE IO"),

      ),
      body: new Container(
        child: new  Column(
          children: <Widget>[
            new TextField(
              controller: _editingcontroller= new TextEditingController(),
              decoration: new InputDecoration(
                labelText: 'Write something'
              ),

            ),
            new FlatButton(onPressed:() {
              writeData(_editingcontroller.text);
              refresh();
            }, child: new Text("Save Data")
            ),
            new Padding(padding: EdgeInsets.all(20.0) )
            ,
            new Text("${_x}"),
          ],
          
        )
        ),
      )
    );
}
Future <String>get _localPath async{
    final directory=await  getApplicationDocumentsDirectory();
    //print (directory.path);
    return directory.path;
}

Future <File> get _localfile async{
    final path=await _localPath;

    return new File('$path/data.txt');
}
Future<File> writeData(String message) async{
    final file =await _localfile;
    return file.writeAsString("$message");
}

Future<String> readData() async{
    try {
      final file=await _localfile;
      String data= await file.readAsString();
      return data;

    }
    catch (e)
  {
    return "nothing saved yet";
  }
}

}
