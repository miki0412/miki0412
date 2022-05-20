import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_practice/sns_practice.dart';

class MakeAccountPage extends StatefulWidget {

  @override
  _MakeAccountPageState createState() => _MakeAccountPageState();
}

class _MakeAccountPageState extends State<MakeAccountPage> {

  String newemail = "";
  String newpassword = "";
  String username = "";

  void hendleSignUp()async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newemail,
        password: newpassword,
    );
    User user = userCredential.user!;
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'id': user.uid,
      'mail': user.email,
      'username': username,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント作成ページ', style: TextStyle(color: Color(0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body: Center(
       child:SizedBox(
        width:MediaQuery.of(context).size.width/2,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                Flexible(
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'メールアドレスを入力してください',border: OutlineInputBorder(),),
                      onChanged: (String value) {
                        setState(() {
                          newemail = value;
                        });
                      },
                    )
                ),
                SizedBox(height:50),
                Flexible(
                    child: TextField(
                      decoration: const InputDecoration(labelText:'パスワードを入力してください',border: OutlineInputBorder(),),
                      obscureText: true,
                      onChanged: (String value) {
                        setState(() {
                          newpassword = value;
                        });
                      },
                    )
                ),
               SizedBox(height: 50),
               Flexible(
                   child: TextField(
                     decoration: const InputDecoration(labelText: 'ユーザー名を入力してください',border: OutlineInputBorder(),),
                     onChanged: (String value) {
                       setState(() {
                         username = value;
                       });
                     },
                   )
               ),
            SizedBox(height:50,),
            ElevatedButton(
              onPressed: () {hendleSignUp();},
              child:Text('アカウント作成'),
            ),
            SizedBox(height:50,),
            TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return SnsPractice();})),
                child: Text('ログインはこちらから'),
            ),
          ],
        )
       ),
      ),
    );
  }
}