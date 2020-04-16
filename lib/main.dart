import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      home: Myapp(),
    )
);

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {


  String name;
  final myController = TextEditingController();
  final databaseReference = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore Demo'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),
              RaisedButton(
                child: Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              RaisedButton(
                child: Text('Update Record'),
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                child: Text('Delete Record'),
                onPressed: () {
                  deleteData();
                },
              ),

      TextField(
        controller: myController,
        onChanged: (name){
          name = name;
          print(name);

        },

      ),

      FloatingActionButton(
        onPressed: () {
            new Text(myController.text);
            createRecord();
             },
      ),
            ],
          )), //center
    );
  }




  //get rid of data thats in limbo after calling to it
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

// Create Database Record
  void createRecord() async {
    // Way #1
    await databaseReference.collection("Menu")
        .document("Italian")
        .setData({
      'Cheese': 07.10,
      'description': 'Cheese Pizza'
    });
  }

  // Getting Data From Firebase
  void getData() {
    databaseReference
        .collection("Menu")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  //Updating specific record in Firebase
  void updateData() {
    try {
      databaseReference
          .collection('Menu')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

//Deleting Firebase Record
  void deleteData() {
    try {
      databaseReference
          .collection('Menu')
          .document('1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}


//  {
//  databaseReference.collection("Menu").getDocuments().then((QuerySnapshot snapshot) {snapshot.documents.forEach((f) => print('${f.data}}'));});
//}