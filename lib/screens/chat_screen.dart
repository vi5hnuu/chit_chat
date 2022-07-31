import 'package:chit_chat/widgets/chat/create_new_message.dart';
import 'package:chit_chat/widgets/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chatScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.blue.withOpacity(0.6),
        actions: [
          Container(
            margin: EdgeInsets.all(10).copyWith(right: 20),
            child: OutlinedButton.icon(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                'Bye',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final ans = await showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: Text('LogOut'),
                        content: Text('You will be logged out of the page.\nDo you want to leave ?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text('Ok'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                              backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.4)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text('Back'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.withOpacity(0.4)),
                            ),
                          ),
                        ],
                      );
                    },
                    barrierDismissible: false);
                if (ans) {
                  FirebaseAuth.instance.signOut();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white10),
                elevation: MaterialStateProperty.all(2),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/chat_background.png'),
                fit: BoxFit.contain)),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
