import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/top_page.dart';
import 'package:flutter_firebase_practice/my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_practice/login.dart';

class AccountRegisterPage extends StatefulWidget {
  const AccountRegisterPage({Key? key}) : super(key: key);

  @override
  _AccountRegisterPageState createState() => _AccountRegisterPageState();
}

class _AccountRegisterPageState extends State<AccountRegisterPage> {

  String email = '';
  String password = '';
  String name = '';
  String username = '';
  String gender = '';

  void addUser()async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = userCredential.user!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'id':user.uid,
      'mail': email,
      'username': username,
      'gender':gender,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () async {
              await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
              return TopPage();
              }));}
          ),
          title: const Text('Cooking Page', style: TextStyle(color: Color(0xffeeeeee),
              fontSize: 20,
              fontWeight: FontWeight.bold),),
        ),
        body:Center (
          child:SizedBox(
            width:MediaQuery.of(context).size.width/2,
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child:Text('メールアドレス',textAlign: TextAlign.left,),
                ),
                Flexible(
                    child:TextField(
                      decoration: const InputDecoration(labelText: '@example.com',border:OutlineInputBorder(),),
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                    )
                ),
                SizedBox(height:50),
                Container(
                  width: double.infinity,
                  child:Text('メールアドレス（確認用）',textAlign: TextAlign.left,),
                ),
                Flexible(
                    child:TextField(
                      decoration: const InputDecoration(labelText: '@example.com',border: OutlineInputBorder(),),
                      onChanged:  (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                    )
                ),
                SizedBox(height: 50),
                Container(
                    width: double.infinity,
                    child: Text('パスワード',textAlign: TextAlign.left,)
                ),
                Flexible(
                    child:TextField(
                      decoration: const InputDecoration(labelText: 'パスワードを入力してください',border: OutlineInputBorder(),),
                      obscureText: true,
                      onChanged:  (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                    )
                ),
                SizedBox(height: 50),
                Container(
                    width: double.infinity,
                    child: Text('パスワード（確認用）',textAlign: TextAlign.left,)
                ),
                Flexible(
                    child:TextField(
                      decoration: const InputDecoration(labelText: 'パスワードを入力してください',border: OutlineInputBorder(),),
                      obscureText: true,
                      onChanged:  (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                    )
                ),
                SizedBox(height: 50),
                Container(
                    width:double.infinity,
                    child: Text('性別を選択してください',textAlign: TextAlign.left,)
                ),
                Flexible(
                  child:TextField(
                    onChanged: (String value) {
                      gender = value;
                    },
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  child: Text('ユーザーネーム',textAlign: TextAlign.left,),),
                Flexible(
                    child:TextField(
                      decoration: const InputDecoration(labelText: 'ユーザーネームを入力してください',border: OutlineInputBorder(),),
                      onChanged:  (String value) {
                        setState(() {
                          username = value;
                        });
                      },
                    )
                ),
                TextButton(
                    onPressed: (){addUser();},
                    child: Text('登録')
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return Login();})),
                  child: Text('ログインはこちらから'),
                )
              ],
            ),
          ),
        )
    );
  }
}