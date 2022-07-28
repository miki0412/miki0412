import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/postpage.dart';
import 'package:flutter_firebase_practice/top_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPage extends StatefulWidget {

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection('posts').snapshots();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  late String userName;

  getUserName() async {
    DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection(
        'users').doc(userId).get();
    Map<String, dynamic> userData = userDocument.data()! as Map<String,
        dynamic>;
    userName = userData['username'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading:TextButton(
          child:Text('TOP',style:TextStyle(color:Colors.white)),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return TopPage();})),
        ),
        title: const Text('Cooking Page', style: TextStyle(color: Color(
            0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body:Center (
            child:SizedBox(
              width:MediaQuery.of(context).size.width/2,
              child: Column (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child:Text('マイページ'),
                     ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: 150,
                    height: 150,
                          decoration: BoxDecoration(
                            border:Border.all(color: Colors.black),
                          ),
                          child:Text('画像',textAlign:TextAlign.center),
                      ),
                  SizedBox(
                    height:150,
                  ),
                  Container(
                    child:TextButton(
                        onPressed: (){},
                        child:Text('情報')
                      ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                    child:TextButton(
                      onPressed: (){},
                      child:Text('お気に入り一覧')
                    )
                  ),
                  SizedBox(
                    height:70,
                  ),
                  Container(
                    child:TextButton(
                      onPressed: (){},
                      child:Text('投稿一覧')
                    )
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(child:
                     TextButton(
                      onPressed: () async {
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:(context) {
                                return Postpage();
                              }),
                        );},
                      child: Text('投稿ページ'),
                  ),),
                    ]
              ),
            ),
      ),
    );
  }
}