import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool _isValidText=false;
  var _messageController=TextEditingController();

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add(
        {
          'text':_messageController.text,
          'createdAt':Timestamp.now(),
          'userId':FirebaseAuth.instance.currentUser!.uid,
        });//do not await
    _messageController.clear();
    _isValidText=false;
    /*
    we can show spinner but that not good but we can do this on chat entered->send->async send to db->ckear _enteredtext_disable button
    * */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8).copyWith(top: 15),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Enter a message.',
                label: Text('message'),
                errorMaxLines: 1,
              ),
              onChanged: (message){
                setState(() {
                  if(_messageController.text.isEmpty)
                    _isValidText=false;
                  else
                    _isValidText=true;
                });
              },
            ),
          ),
          IconButton(
            onPressed: !_isValidText ? null : _sendMessage,
            disabledColor: Colors.grey,
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send,size: 35,),
          )
        ],
      ),
    );
  }
}
