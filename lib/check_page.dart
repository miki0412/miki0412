import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_practice/recipe_page.dart';
import 'package:flutter_firebase_practice/favorite_page.dart';

class CheckPage extends StatefulWidget {

  @override
  _CheckPageState createState() => _CheckPageState();
}
class _CheckPageState extends State<CheckPage> {

  bool?favorite;
   //↑ Null safetyが有効となったため必ず？かlateもしくは=""を代入してnullにならないようにしないとエラーになってしまう
  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cooking Page', style: TextStyle(color: Color(0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body:Center (
        child:SizedBox(
            width:MediaQuery.of(context).size.width/2,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child:
                 StreamBuilder<QuerySnapshot>(
                    stream: userStream,
                    builder: (context,snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> usersData = snapshot.data!.docs;
                        return ListView.separated(
                          itemCount: usersData.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> userData = usersData[index].data()! as Map<String, dynamic>;
                            return Card(
                              child: ListTile(
                                title:Container(
                                  child: Column(
                                    children: [
                                      Row(
                                          children:[
                                            Expanded(child: Text('${userData['cookname']}'),),
                                            Expanded(child: TextButton(
                                              child:Icon(
                                                favorite == true?Icons.favorite:Icons.favorite_border,
                                                color:favorite == true?Colors.pink:Colors.black38,
                                              ),
                                              onPressed: (){
                                                setState(() {
                                                  if(favorite != true){
                                                    favorite = true;
                                                  }else{
                                                    favorite = false;
                                                  }
                                                });
                                              },
                                            ),),
                                      ]),
                                      Container(width:double.infinity,child:Text('${userData['recipe']}',textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,),),
                                      Container(width:double.infinity,child:Text('${userData['onpoint']}',textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,),),
                                      Container(width:double.infinity,child:Text('Produced By${userData['content']}',textAlign:TextAlign.right)),
                                      ],),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        );
                      }else{
                        return const Center(child:CircularProgressIndicator());
                      }
                    }
                    ,),),
              ],
            )
        ),
      ),
    );
  }
}