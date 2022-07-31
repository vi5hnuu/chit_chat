import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final Alignment bubbleAlignment;
  final bubbleColor;
  final Key key;
  final String userImage;
  const MessageBubble(
      {required this.userName,
      required this.message,
      required this.bubbleAlignment,
      required this.bubbleColor,
      required this.key,
      required this.userImage
      });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            children: [
              Bubble(
                child: Text(message),
                padding: BubbleEdges.all(10),
                nip: bubbleAlignment == Alignment.centerLeft
                    ? BubbleNip.rightBottom
                    : BubbleNip.leftBottom,
                color: bubbleColor,
                stick: true,
                elevation: 4,
                margin: BubbleEdges.only(
                    bottom: 25,
                    left: bubbleAlignment == Alignment.centerLeft
                        ? 50
                        : mediaQuery.size.width * 0.25,
                    right: bubbleAlignment == Alignment.centerLeft
                        ? mediaQuery.size.width * 0.25
                        : 50),
                alignment: bubbleAlignment,
                radius: Radius.circular(20.0),
              ),
              Positioned(
                child: Text(
                  userName,
                  textAlign: bubbleAlignment == Alignment.centerLeft
                      ? TextAlign.left
                      : TextAlign.right,
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                  ),
                ),
                bottom: 25-8-5,
                left: bubbleAlignment == Alignment.centerLeft ? 15+50 : 0,
                right: bubbleAlignment == Alignment.centerLeft ? 0 : 15+50,
              ),
              Positioned(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(child: Image.network(userImage,fit: BoxFit.cover,width: 25,height: 25,),clipBehavior: Clip.hardEdge,borderRadius: BorderRadius.circular(25),),
                  alignment: bubbleAlignment,
                ),
                left: bubbleAlignment==Alignment.centerLeft ? 5 : 0,
                right: bubbleAlignment==Alignment.centerLeft ? 0 : 5,
              )
            ],
          ),
        ),
      ],
    );
  }
}
