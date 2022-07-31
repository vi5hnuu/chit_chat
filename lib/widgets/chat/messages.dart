import 'package:chit_chat/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
      builder: (BuildContext ctx,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var chatDocs=snapshot.data!.docs;
        final _loggedInUserId=FirebaseAuth.instance.currentUser!.uid;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (BuildContext x,int index){
              final  key=ValueKey(chatDocs[index].id);
              final userId=chatDocs[index]['userId'];
              // print(userId);
              // FirebaseFirestore.instance.collection('users').doc(userId).get().then((value) => print(value.data()));
              if(chatDocs[index]['userId']==_loggedInUserId)
              return MessageBubble(key: key,userImage:chatDocs[index]['userImageUrl'] ,userName:chatDocs[index]['userName'],message:chatDocs[index]['text'],bubbleAlignment: Alignment.centerRight,bubbleColor: Color.fromRGBO(225, 255, 255, 1.0),);
              else
              return MessageBubble(key:key,userImage:chatDocs[index]['userImageUrl'],userName:chatDocs[index]['userName'],message:chatDocs[index]['text'],bubbleAlignment: Alignment.centerLeft,bubbleColor: Color.fromRGBO(225, 255, 199, 1.0),);
          },
        );
    },
    );
  }
}
