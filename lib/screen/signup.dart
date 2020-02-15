import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



class MyData {
  String name;
  String phone;
  String email;
  String age;
  MyData(this.name, this.phone, this.email, this.age);
}

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() {
    // TODO: implement createState
    return  _SignUp();
  }

//  @override
//  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  File _image; // dart.io 추상클래스
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // ???
  FirebaseUser _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source); // 이미지 픽커

    if (image == null) return;
    setState(() {
      _image = image;
    });
    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    StorageReference storageReference =
                  _firebaseStorage.ref().child("profile/${_user.uid}");
//    // 파일 업로드
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);

    // 파일 업로드까지 대기
    await storageUploadTask.onComplete;

    // 업로드한 사진의 URL 휙득
    String downloadURL = await storageReference.getDownloadURL();

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        // 업로드 이미지를 출력할 CircleAvatar
                        CircleAvatar(
                          backgroundImage:
                          (_image != null) ? FileImage(_image) : NetworkImage(""),
                          radius: 30,
                        ),
                        // 업로드할 이미지를 선택할 이미지 피커 호출 버튼
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            RaisedButton(
//                              child: Text("Gallery"),
//                              onPressed: () {
//                                _uploadImageToStorage(ImageSource.gallery);
//                              }),
//                            RaisedButton(
//                              child: Text("Camera"),
//                              onPressed: () {
//                                _uploadImageToStorage(ImageSource.gallery);
//                              })
//                          ],
//                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        // 업로드 된 이미지를 출력할 CircleAvatar
                        // 파베에 사진 업로드한 뒤에 URL 가져와서 NetworkImage 이요해 출력
//                        CircleAvatar(
//                          backgroundImage: NetworkImage(_profileImageURL),
//                          radius: 30,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.all(8.0),
//                          child: Text(_profileImageURL),
//                        )
                      ],
                    ),
                  ),


                  TextFormField(
//                    initialValue: "Name",
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Birth Day',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone Number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                    child: FloatingActionButton(
                      child: Text("Submut"),
                        onPressed: () => {
                          _formKey.currentState.validate() ?
                          print("YES") : print("No"),
                          print(_formKey.currentState)
                        }
                    ),
                  )
                ],
              )
          ),
        ),
      )

    );
  }
}