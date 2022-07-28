import 'package:flutter_firebase_practice/account_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/my_page.dart';
import 'package:flutter_firebase_practice/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TopPage extends StatefulWidget {

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Page', style: TextStyle(color: Color(0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
        actions: [
          TextButton(
            child:Text('ログイン',
              style: TextStyle(fontSize: 10,color: Color(0xffeeeeee),fontWeight: FontWeight.bold),
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Login();})),
          ),
         IconButton(
           icon:Icon(Icons.account_circle),
           onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return MyPage();})),
         ),
         IconButton(
         onPressed: (){},
         icon: Icon(Icons.search),
         ),
        ],
      ),
      body:Center (
        child:SizedBox(
            width:MediaQuery.of(context).size.width/2,
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextButton(
                      onPressed: () async {
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:(context) {
                                return AccountRegisterPage();
                              }),
                        );},
                      child: Text('アカウント登録はこちらから')
                  ),),
              ],
            )
        ),
      ),
    );
  }
}