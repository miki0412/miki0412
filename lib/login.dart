import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/my_page.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = '';
  String password = '';
  String infotext = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Page', style: TextStyle(color: Color(
            0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
     body:Center(
      child:SizedBox(
        width:MediaQuery.of(context).size.width/2,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child:Text(infotext)
            ),
            SizedBox(
              height: 50,
            ),
            Flexible(
                child: TextField(
                  decoration: InputDecoration(labelText: 'メールアドレスを入力してください'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                )
            ),
            SizedBox(
              height: 30,
            ),
            Flexible(
                child:TextField (
                  decoration: InputDecoration(labelText: 'パスワードを入力してください'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  }
                )
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                child:Text('ログイン'),
                onPressed: () async {
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                        await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password
                    );
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) {
                            return MyPage();
                          }),
                    );
                  }catch(e){
                    setState(() {
                      infotext = 'ログインできませんでした:${e.toString()}';
                    });
                  }
                },
                )
          ]
         ),
      ),
    ),
    );
  }
}
