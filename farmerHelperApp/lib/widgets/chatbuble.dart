import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({this.message,this.data});
  final String message;
  final int data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Bubble(
        radius: Radius.circular(15),
        color: data == 0?Colors.blue:Colors.green,
        elevation: 2,
        alignment: data == 0?Alignment.topLeft:Alignment.topRight,
        nip: data == 0?BubbleNip.leftBottom:BubbleNip.rightTop,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage("images/default.jpg"),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
