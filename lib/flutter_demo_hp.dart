import 'package:flutter/material.dart';

class FlutterDemoHp extends StatefulWidget {
  const FlutterDemoHp({Key? key,}) : super(key: key);

  @override
  State<FlutterDemoHp> createState() => _FlutterDemoHpState();
}

class _FlutterDemoHpState extends State<FlutterDemoHp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Hp', style: TextStyle(color: Color(0xffeeeeee), fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Column(children:<Widget>[
           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              Container(TextField(
                decoration: const InputDecoration(border: OutlineInputBorder(),),
              ),
              Container(TextField(
                  decoration: const InputDecoration(border: OutlineInputBorder()),),
              ),
           ),
      ]),
    );
  }
}