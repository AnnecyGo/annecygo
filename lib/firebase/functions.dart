import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getTestValue() {
  return FutureBuilder(
      future: Firestore.instance.collection('test').getDocuments(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data.documents.length != 0) {
            var value =
                snapshot.data.documents.map((DocumentSnapshot document) {
              return document['value'];
            }).toList();

            print(value);

            return Text("Value : " + value[0],
                style: TextStyle(color: Colors.red));
          }
        }
      });
}
