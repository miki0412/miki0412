import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  PostPage(this.user);
  final user;

  @override
  _PostPageState createState() => _PostPageState();
}
class _PostPageState extends State<PostPage> {

  final postPageController = TextEditingController();
  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection('posts').snapshots();

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
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Row(
                     children:<Widget>[
                      Flexible(
                        child: TextField(
                          controller: postPageController,
                          maxLength: 50,
                          decoration: const InputDecoration(labelText:'コメントを入力してください',border: OutlineInputBorder(),),
                      ),
                      ),
                       SizedBox(width:20),
                       IconButton(
                           onPressed: () async {
                             final email = widget.user.email;
                             await FirebaseFirestore.instance.collection('posts').doc().set({
                               'comment':postPageController.text,
                               'content':email,
                             });
                           },
                           icon: Icon(Icons.send),
                       ),
                       StreamBuilder<QuerySnapshot>(
                         stream: userStream,
                         builder: (context,snapshot) {
                           if(snapshot.hasData) {
                             List<DocumentSnapshot> usersData = snapshot.data!.docs;
                             return ListView.separated(
                                 itemCount: usersData.length,
                                 itemBuilder: (BuildContext context,int index) {
                                   Map<String, dynamic> userData = usersData[index].data()! as Map<String, dynamic>;
                                   return ListTile(title: Text('${userData['content']}'),subtitle: Text('${userData['comment']}'),);
                                 },
                                 separatorBuilder: (BuildContext context, int index) => const Divider(),
                             );
                            }else{
                              return const Center(child: CircularProgressIndicator());
                          }
                         }
                       ),
                     ],
                   ),
                 ],
               )
             ),
          ),
    );
  }
}