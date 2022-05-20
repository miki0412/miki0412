import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_practice/make_account_page.dart';
import 'package:flutter_firebase_practice/post_page.dart';


class SnsPractice extends StatefulWidget {

  @override
  _SnsPracticeState createState() => _SnsPracticeState();
}

class _SnsPracticeState extends State<SnsPractice> {

  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログインページ', style: TextStyle(color: Color(0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body:Center (
        child:SizedBox(
           width:MediaQuery.of(context).size.width/2,
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Flexible(
                      child:TextField(
                        decoration: const InputDecoration(labelText:'メールアドレス',border: OutlineInputBorder(),),
                        onChanged: (String value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                  ),
                  SizedBox(width:50),
                  Flexible(
                      child:TextField(
                        decoration: const InputDecoration(labelText: 'パスワード',border: OutlineInputBorder(),),
                        obscureText: true,
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                      )
                  ),
                ],
              ),
              SizedBox(height:50,),
              ElevatedButton(
                  onPressed: ()async{
                    try {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                       await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return PostPage();
                          })
                      );
                    }catch (e){
                      setState(() {
                        'ログインに失敗しました:${e.toString()}';
                      });
                    }
                  },
                  child: Text('ログイン',),
               ),
              SizedBox(height:50,),
              TextButton(
                onPressed: () async {
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder:(context) {
                          return MakeAccountPage();
                      })
                  );
                },
                  child:Text('アカウントをお持ちでない方はこちらから'),
              ),
            ],
          ),
        ),
        )
      );
  }
}