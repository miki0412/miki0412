import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super (key: key);

  @override
  _SignUpState createState() => _SignUpState();

}
class _SignUpState extends State<SignUp>{

  void handleSignUp() async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email:"spring@exsample.com",
      password:"password"
    );
    User user = userCredential.user!;
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'id':user.uid,
      'mail':user.email
    });
}

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body:Center (
          child:ElevatedButton(
           onPressed:(){handleSignUp();},
           child:const Text('アカウント作成',style: TextStyle(color: Colors.white),),
           style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
          ),
        ),
      ),
    );
  }
}