import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/make_account_page.dart';

class PostPage extends StatefulWidget {

  @override
  _PostPageState createState() => _PostPageState();
}
class _PostPageState extends State<PostPage> {

  final postPageController = TextEditingController();
  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection('posts').orderBy('timestamp').snapshots();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿', style: TextStyle(color: Color(0xffeeeeee),
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
                         if(snapshot.hasData) {
                           List<DocumentSnapshot> usersData = snapshot.data!.docs;
                             return ListView.separated(
                               itemCount: usersData.length,
                               itemBuilder: (BuildContext context,int index) {
                                 Map<String, dynamic> userData = usersData[index].data()! as Map<String, dynamic>;
                                 return Card(
                                  child:ListTile(
                                    title: Text('${userData['content']}'),
                                    subtitle: Text('${userData['comment']}'),
                                  ),);
                               },
                               separatorBuilder: (BuildContext context, int index) => const Divider(),
                             );
                         }else{
                           return const Center(child: CircularProgressIndicator());
                         }
                       }
                   ),),
                   Row(
                     children:<Widget>[
                      Flexible(
                        child: TextField(
                          enabled: true,
                          controller: postPageController,
                          maxLength: 50,
                          decoration: const InputDecoration(labelText:'コメントを入力してください',border: OutlineInputBorder(),),
                      ),
                      ),
                       IconButton(
                         icon:Icon(Icons.send),
                           onPressed: () async {
                             await FirebaseFirestore.instance.collection('posts').doc().set(
                                 {
                                   'comment': postPageController.text,
                                   'content':
                                     StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
                                      builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(snapshot.data!['username']);
                                        } else {
                                          return Container();
                                        }
                                      }
                                    ),
                                   'timestamp': FieldValue.serverTimestamp(),
                                 });
                             postPageController.clear();
                       })
                     ],
                   ),
                 ],
               )
             ),
          ),
    );
  }
}