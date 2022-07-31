import 'dart:io';

import 'package:chit_chat/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/authScreen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth=FirebaseAuth.instance;
  var _isLoading=false;
  Future<void> _submitAuthForm(
      {required String email,
      required String pass,
      String? username,
      required bool isLogin,File? pickedImage}) async {
    UserCredential userCredential;
    try{
      setState(() {
        _isLoading=true;
      });
      if(isLogin){
        userCredential=await _auth.signInWithEmailAndPassword(email: email, password: pass);
      }else{
        userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
        final ref=FirebaseStorage.instance.ref().child('user_images').child('${userCredential.user!.uid}.jpg');
        await ref.putFile(pickedImage!).whenComplete(()async{
          final imageUrl=await ref.getDownloadURL();
          FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(
              {'userName':username,'email':email,'image_url':imageUrl});
        });
        //store username

      }

    }on PlatformException catch(err){
      var messsage='An error occured, please check your credentials!';
      if(err.message!=null){
        messsage=err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messsage),
      ),);
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
      ),);
    }finally{
      if(!mounted)
        return;
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/auth_background.png',
                ),
                fit: BoxFit.contain),),
        child: AuthForm(submitFn: _submitAuthForm,isLoading:_isLoading),
      ),
    );
  }
}
