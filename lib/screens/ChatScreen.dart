import 'package:farmhelper/widgets/chatbuble.dart';
import 'package:farmhelper/widgets/common_appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:translator/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool spinner = false;
  int x=0;
  String k="Please write first then press to hear.",l="en-IN";
  final FlutterTts flutterTts = FlutterTts();
  void messageResponse(query) async {
    setState(() {
      spinner = true;
    });
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String lcode = _prefs.getString('language_code');
    final obj = GoogleTranslator();
    if (lcode == "hi")
    {
      String p=query;
      var trans = await obj.translate(p, to: 'en');
      query = trans.toString();
    }
    AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/arctic-operand-256808-c98338482a59.json")
        .build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: "en");
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    k = ((aiResponse.getListMessage()[0]["text"]["text"][0]).toString());


    if (lcode == "hi")
    {
      l = "hi-IN";

      var trans = await obj.translate(k, to: 'hi');
      String s = trans.toString();
      k = s;
    }


    setState(() {
      messages.insert(0, {
        "data": 0,
        "message":k
//            (aiResponse.getListMessage()[0]["text"]["text"][0]).toString()
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
    Future _speaker() async
    {
      await flutterTts.setLanguage(l);
      await flutterTts.speak(k);
      print("speaking");
    }
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        icon: Icon(Icons.headset),
                        onPressed:(){

                          _speaker();
                        },
                      ),
                    ),
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

//                            _speaker();
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