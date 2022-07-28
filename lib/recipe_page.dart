import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipePage extends StatefulWidget {

  @override
  _RecipePageState createState() => _RecipePageState();
}
class _RecipePageState extends State<RecipePage> {

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
                      stream:userStream,
                      builder:(context,snapshot){
                        if(snapshot.hasData){
                          List<DocumentSnapshot> usersData = snapshot.data!.docs;
                          return ListView.separated(
                            itemCount: usersData.length,
                            itemBuilder: (BuildContext context,int index) {
                              Map<String,dynamic> userData = usersData[index].data()! as Map<String,dynamic>;
                              return Container(
                                child:Column(
                                  children: [
                                    Container(
                                      child:Text('${userData['cookname']}'),
                                    ),
                                    Container(
                                      child:Row(
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          );
                        }else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                    )
                ),
              ],
            )
        ),
      ),
    );
  }
}