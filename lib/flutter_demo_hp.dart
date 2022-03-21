import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page',style: TextStyle(color: Color(0xffeeeeee),fontSize: 20,fontWeight:FontWeight.bold),),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            TextField(
            decoration: const InputDecoration(labelText: '＋', border: OutlineInputBorder()),
          ),
            const SizedBox(height: 20,),
            TextField(
            obscureText: true,
            decoration: const InputDecoration(labelText: '−', border: OutlineInputBorder()),
          ),
            const SizedBox(height: 20,),
            ]
          ),
           )
      )
    );
  }
}