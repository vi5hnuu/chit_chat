import 'package:chit_chat/screens/auth_screen.dart';
import 'package:chit_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        ChatScreen.routeName:(BuildContext x)=>ChatScreen(),
        AuthScreen.routeName:(BuildContext x)=>AuthScreen(),
      },
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext ctx,userSnapshot){
          if(userSnapshot.hasData)
              return ChatScreen();
          else
            return AuthScreen();
        },
      ),
    );
  }
}
