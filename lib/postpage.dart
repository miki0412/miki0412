import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/top_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_practice/check_page.dart';

class Postpage extends StatefulWidget {

  @override
  _PostpageState createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {

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

  final cooknameController = TextEditingController();
  final recipeController = TextEditingController();
  final onepointController = TextEditingController();

  String cookname = '';
  String comment = '';
  File? _image;//画像ファイルを保存する変数

  String _imageUrl = '';//アップロードした画像のURLを保存する変数

  //端末の画像を選択する
  Future<void> openImagePicker() async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {

      _image = File(pickedImage.path);

      uploadFile();
    }
  }

  //画像のアップロード
  Future<void> uploadFile()async{
    //現在の時刻をミリ秒単位で取得。画像のidとして使用
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    //ストレージ上のパスを設定できる。この場合/images/にidの名前で画像が格納される。
    Reference reference = FirebaseStorage.instance.ref().child('images').child(id);

    //画像のアップロード
    await reference.putFile(_image!);

    //アップロードした画像のURLを取得
    _imageUrl =  await reference.getDownloadURL();

    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading:TextButton(
          child:Text('TOP',style:TextStyle(color:Colors.white)),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {return TopPage();})),
        ),
        title: const Text('Cooking Page', style: TextStyle(color: Color(0xffeeeeee),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
      ),
      body:Center(
        child:SizedBox(
          width:MediaQuery.of(context).size.width/2,
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                 Container(
                  child:Text('料理名'),
                ),
                 const SizedBox(height: 20,),
                 IconButton(
                   icon:Icon(Icons.image),
                    onPressed: (){
                     openImagePicker();
                    },
               ),],),
                Flexible(
                  child: TextField(
                    controller: cooknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        cookname = value;
                      });
                    },
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Container(
                    child:Text('作り方'),
                  ),
                  const SizedBox(height: 20,),
                  IconButton(
                    icon:Icon(Icons.image),
                    onPressed: (){
                      openImagePicker();
                    },
                  ),],),
              Flexible(
                  child: TextField(
                    controller: recipeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(50),
                    ),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  child: Text('ワンポイントアドバイス',textAlign: TextAlign.left,)
              ),
              Flexible(
                  child:TextField(
                    controller: onepointController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(35),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        comment = value;
                      });
                    },
                  )
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  child: ElevatedButton(
                    child: Text('確認画面へ'),
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('posts').doc().set(
                            {
                              'content': userName,
                              'cookname': cooknameController.text,
                              'recipe': recipeController.text,
                              'onpoint': onepointController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                            });
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) {
                                return CheckPage();
                              }),
                        );
                      }
                  ),
              )
            ],
           ),
        ),
      ),
    );
  }
}