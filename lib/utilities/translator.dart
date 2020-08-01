import 'package:translator/translator.dart';

class Translator {
  String s;
  Translator();

  Future<String> hindi(String s) async {
    final obj = GoogleTranslator();
    try {
      var trans = await obj.translate(s, to: 'hi');
      s = trans.toString();
      return s;
    } catch (e) {
      print(e);
      return '';
    }
  }
}
