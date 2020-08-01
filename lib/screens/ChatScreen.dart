import 'package:farmhelper/widgets/chatbuble.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool spinner = false;
  void messageResponse(query) async {
    setState(() {
      spinner = true;
    });
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/arctic-operand-256808-c98338482a59.json")
        .build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message":
            (aiResponse.getListMessage()[0]["text"]["text"][0]).toString()
      });
    });
    setState(() {
      spinner = false;
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(4),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ChatBubble(
                    message: messages[index]["message"].toString(),
                    data: messages[index]["data"],
                  ),
                ),
              ),
              Container(
//              margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(4),
                color: Colors.black12,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: messageInsert,
                        decoration: InputDecoration.collapsed(
                            hintText: "Send your message..."),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (messageInsert.text.isEmpty) {
                            print("Empty Message not allowed");
                          } else {
                            setState(() {
                              messages.insert(0,
                                  {"data": 1, "message": messageInsert.text});
                            });
                            messageResponse(messageInsert.text);
                            messageInsert.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
