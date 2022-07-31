import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';


class MessageBubble extends StatelessWidget {
  final String message;
  final Alignment bubbleAlignment;
  final bubbleColor;
  final Key key;
  const MessageBubble({required this.message,required this.bubbleAlignment,required this.bubbleColor,required this.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children :[
        Expanded(
          child: Bubble(
            child: Text(message),
            padding: BubbleEdges.all(10),
            nip:bubbleAlignment==Alignment.centerLeft ? BubbleNip.rightBottom : BubbleNip.leftBottom,
            color: bubbleColor,
            stick: true,
            elevation: 4,
            margin: BubbleEdges.only(bottom: 5,left: bubbleAlignment==Alignment.centerLeft ? 0 : mediaQuery.size.width*0.25,right: bubbleAlignment==Alignment.centerLeft ? mediaQuery.size.width*0.25 : 0 ),
            alignment: bubbleAlignment,
            radius:Radius.circular(20.0),
          ),
        ),
      ],
    );
  }
}
