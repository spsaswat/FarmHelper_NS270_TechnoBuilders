import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmer Helper',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Farmer Helper'),
        ),
        body: WebView(
          initialUrl: "https://abhishek-st.github.io/",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}