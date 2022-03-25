import 'package:flutter/material.dart';

class FlutterDemoHp extends StatefulWidget {
  const FlutterDemoHp({Key? key,}) : super(key: key);

  @override
  State<FlutterDemoHp> createState() => _FlutterDemoHpState();
}

class _FlutterDemoHpState extends State<FlutterDemoHp> {

  final numberEditingController = TextEditingController();
  final number_EditingController = TextEditingController();

  int a = 0;
  int b = 0;
  int c = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page', style: TextStyle(color: Color(0xffeeeeee), fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child:SizedBox(
          width:MediaQuery.of(context).size.width/2,
         child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget>[
           Row(
            children: [
              Flexible(
               child:TextField(
                controller: numberEditingController,
                decoration: const InputDecoration(border: OutlineInputBorder(),),
                onChanged: (text){
                  setState(() {
                    a = int.tryParse(text) ?? 0;
                  });
                },
               ),),
              const SizedBox(width:50,),
              Flexible(
               child:TextField(
                controller: number_EditingController,
                decoration: const InputDecoration(border: OutlineInputBorder(),),
                 onChanged: (text){
                  setState(() {
                    b = int.tryParse(text) ?? 0;
                  });
                 },
              ),),
              const SizedBox(width:50,),
              Flexible(
                child:Text('結果：'),
              ),
              Flexible(
                child:Text(c.toString()),
              ),
            ],
           ),
            Row(
              children:[
                SizedBox(
                  width:100,
                  height:50,
                 child:ElevatedButton(
                  child:Text('＋',),
                  onPressed: (){
                    setState((){
                      c = a + b;
                      });
                    },
                 ),
                ),
                const SizedBox(width:20,),
                SizedBox(
                  width:100,
                  height:50,
                 child:ElevatedButton(
                  child:const Text('−'),
                  onPressed: (){
                    setState((){
                      c = a - b;
                      print(c);
                    });
                  },
                 ),
                ),
                const SizedBox(width:20,),
                SizedBox(
                  width:100,
                  height:50,
                 child:ElevatedButton(
                  child:const Text('×'),
                  onPressed: (){
                    setState(() {
                      c = a * b;
                    });
                  },
                 ),
                ),
                const SizedBox(width:20,),
                SizedBox(
                  width:100,
                  height:50,
                 child:ElevatedButton(
                  child:const Text('÷'),
                  onPressed: (){
                    setState(() {
                      c = a ~/ b;
                    });
                  },
                 ),
                ),
             ],
            )
           ],
         ),
      ),
      ),
    );
  }
}