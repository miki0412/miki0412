import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super (key: key);

 /* @override
  _SignInState createState() => _SignInState();

}
class _SignInState extends State<SignIn>{*/

  handleSignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: "spring@exsample.com",
          password: "password"
      );
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        print('登録されていないメールアドレスです');
      } else if(e.code == 'wrong-password') {
        print('パスワードが違います');
      }
    }
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body:Center (
        child:ElevatedButton(
          onPressed:(){handleSignIn();},
          child:const Text('ログイン',style: TextStyle(color: Colors.white),),
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
          ),
        ),
      ),
    );
  }
}