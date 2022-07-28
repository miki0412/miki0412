import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/sns_practice.dart';

class PostPage extends StatefulWidget {

  @override
  _PostPageState createState() => _PostPageState();
}
class _PostPageState extends State<PostPage> {

  final postPageController = TextEditingController();
  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection('posts').orderBy('timestamp').snapshots();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  late String userName;

  getUserName()async{
    DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userData= userDocument.data()! as Map<String, dynamic>;
    userName = userData['username'];
  }

  @override
  void initState() {
    super.initState();
    //初期化時に一度だけ呼ばれるメソッド
    //上記の２コードの後に処理をかく
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿', style: TextStyle(color: Color(0xffeeeeee),
          fontSize: 20,
          fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed:() async {
                await FirebaseAuth.instance.signOut();
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return SnsPractice();
                  })
                );
              },
              icon: Icon(Icons.logout),
          )
        ],
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
                                   color:userData['content'] == userName ?
                                   Colors.lime
                                   : Colors.white,
                                  child:ListTile(
                                    title: Text('${userData['content']}'),
                                    subtitle: Text('${userData['comment']}'),
                                    trailing: userData['content'] == userName ?
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance.collection('posts').doc(userData[userId]).delete();
                                        },
                                    )
                                    :null,
                                  ),
                                 );
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
                                   'content': userName,
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