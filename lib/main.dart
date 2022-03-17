import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_practice/sign_in.dart';
import 'package:flutter_firebase_practice/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        ),
        home: const SignIn(/*title:'Firebase Tutorial'*/),
      );
    }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSignedIn = false;

  void checkSignInState(){
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState (() {_isSignedIn = false;});
      } else {
        setState(() {
          _isSignedIn = true;
        });
      }
      });
    }
 @override
 void initState(){
  super.initState();
  checkSignInState();
 }

 @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child:Container (
        child:Text('ログイン成功！'),
      )
    ),
  );
}
  /*const MyHomePage ({Key? key,required this.title}) : super (key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void addUser()async{
    await FirebaseFirestore.instance.collection('users').doc('user3').set({
     'id':'user3',
      'name':'arata',
     'age':'29'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title:Text(widget.title)
    ),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            ElevatedButton(
              onPressed: (){addUser();},
              child:const Text('ユーザー設定',style: TextStyle(color: Colors.white),),
              style:ButtonStyle (
                padding:MaterialStateProperty.all(const EdgeInsets.all(20)),
                shape:MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)))
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}
