import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();
}
class _FavoritePageState extends State<FavoritePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cooking Page', style: TextStyle(color: Color(0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body:Center (
        child:SizedBox(
            width:MediaQuery.of(context).size.width/2,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ],
            )
        ),
      ),
    );
  }
}